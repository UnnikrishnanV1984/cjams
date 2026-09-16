const puppeteer = require('puppeteer');
const axios = require('axios');
const Twig = require('twig'), twig = Twig.twig;
const LOGGER = require('log4js').getLogger("pdfgenerator");

const bootstrapStackColumns = (function () {
    const selectors = [];
    ['sm', 'md', 'lg'].forEach(bp => {
        for (let i = 1; i <= 12; i++) {
            // An element that also carries a col-xs-* class is left alone. A4 at 10mm
            // margins lays out at ~718px, below Bootstrap 3's 768px sm breakpoint, so
            // col-xs-* is the width the browser honours in print anyway - overriding it
            // collapses a deliberate two-column row into a single stacked column.
            selectors.push(`.col-${bp}-${i}:not([class*="col-xs-"])`);
        }
    });
    return `${selectors.join(',')} { float: none !important; width: 100% !important; }`;
})();

const tableLayoutFix = `
    table { display: table !important; width: 100% !important; border-collapse: collapse !important; }
    thead { display: table-header-group !important; }
    tbody { display: table-row-group !important; }
    tfoot { display: table-footer-group !important; }
    tr { display: table-row !important; }
    th, td { display: table-cell !important; }
    /* Keep a row whole rather than splitting its text across the page break. */
    tr { break-inside: avoid !important; page-break-inside: avoid !important; }
    thead { break-inside: avoid !important; }
`;

const LINE_HEIGHT = 1.45;

const compactSpacing = `
    *, body, p, td, th, div, li, span, label, a, strong, b, em {
        line-height: ${LINE_HEIGHT} !important;
    }
    br { line-height: ${LINE_HEIGHT} !important; }
    p { margin: 0 0 4px !important; }
    ul, ol { margin: 0 0 4px !important; }
    li { margin: 0 !important; }
    h1, h2, h3, h4, h5, h6 {
        margin: 4px 0 !important;
        line-height: ${LINE_HEIGHT} !important;
    }
    .table > thead > tr > th,
    .table > thead > tr > td,
    .table > tbody > tr > th,
    .table > tbody > tr > td,
    .table > tfoot > tr > th,
    .table > tfoot > tr > td,
    table th, table td {
        vertical-align: top !important;
    }
    table th > p, table td > p,
    table th > div, table td > div,
    table th > ul, table td > ul,
    table th > ol, table td > ol {
        margin: 0 !important;
    }
    td > *:last-child, th > *:last-child { margin-bottom: 0 !important; }
    .form-group, .row { margin-bottom: 0 !important; }
`;

// /style.css hides the native control inside .md-radiobox / .md-checkbox
// (opacity 0, collapsed to 0x0) because the visible box is meant to be drawn by
// the sibling .md-radiobox-material / .md-checkbox-material span. Templates that
// use the wrapper without that span print nothing at all - no ring, no tick. Give
// those back the browser's own control, and leave wrappers that do carry a
// material span alone so their styled box still renders.
const bareControlFix = `
    .md-radiobox:not(:has(.md-radiobox-material)) input[type="radio"],
    .md-checkbox:not(:has(.md-checkbox-material)) input[type="checkbox"] {
        opacity: 1 !important;
        position: static !important;
        z-index: auto !important;
        width: auto !important;
        height: auto !important;
        overflow: visible !important;
        margin: 0 4px 0 0 !important;
        vertical-align: middle !important;
    }
`;

// /style.css draws the .md-checkbox tick with the md-checkbox-on / md-checkbox-off
// keyframes: an animated stack of box-shadows on a 0x0 pseudo-element, clipped by
// the 20px box. Chrome restarts CSS animations for the print snapshot, so every box
// prints at its 0% frame - and md-checkbox-off starts from the fully-on shape, which
// is why checked and unchecked alike came out as a filled blue square. .md-radiobox
// is unaffected because its dot is a static background and its md-radiobox-off
// keyframes do not exist, so draw the tick the same way: static, off the :checked
// state, with no animation involved.
const checkboxMarkFix = `
    .md-checkbox .md-checkbox-material:before,
    .md-checkbox .md-checkbox-material .check:after {
        animation: none !important;
        -webkit-animation: none !important;
        opacity: 0 !important;
    }
    .md-checkbox .md-checkbox-material .check {
        border-color: #636363 !important;
        background-color: transparent !important;
        -webkit-print-color-adjust: exact;
    }
    /* The tick is the bottom and right border of a rotated box. The borders stay
       0-width until :checked, so an unchecked box prints as an empty square. */
    .md-checkbox .md-checkbox-material .check:before {
        animation: none !important;
        -webkit-animation: none !important;
        box-shadow: none !important;
        background: transparent !important;
        left: 4px !important;
        top: 1px !important;
        margin: 0 !important;
        width: 5px !important;
        height: 10px !important;
        border: 0 solid #2faef8 !important;
        -webkit-transform: rotate(45deg) !important;
        transform: rotate(45deg) !important;
        -webkit-print-color-adjust: exact;
    }
    .md-checkbox input[type="checkbox"]:checked + .md-checkbox-material .check {
        border-color: #2faef8 !important;
    }
    .md-checkbox input[type="checkbox"]:checked + .md-checkbox-material .check:before {
        border-width: 0 2px 2px 0 !important;
    }
`;

// The DHS-letterhead report templates give every .clsOnePage block a hard
// height of 1094px so it fills a sheet. A4's printable box is only ~1047px tall
// at 10mm margins - less once a header or footer is enabled - so those extra
// pixels spill onto a sheet of their own and each block is trailed by a blank
// page. Size the block to its content instead and start each one on a fresh
// page with a real break, which is what the fixed height was approximating.
const ONE_PAGE_BLOCK = '.clsOnePage';
const PAGE_BREAK_CLASS = 'pdf-one-page-break';

// /style.css draws a red rule under every <header> and is injected after the
// template's own <style>, so a template cannot drop it on its own. Templates
// that want a plain letterhead opt in with this class on their <header>; the
// rule matches nothing elsewhere, so other reports keep the red rule.
const PLAIN_HEADER_CLASS = 'clsPlainHeader';

const onePageBlockFix = `
    ${ONE_PAGE_BLOCK} {
        height: auto !important;
        min-height: 0 !important;
        max-height: none !important;
        overflow: visible !important;
    }
    ${ONE_PAGE_BLOCK}.${PAGE_BREAK_CLASS} {
        break-before: page !important;
        page-break-before: always !important;
    }
    header.${PLAIN_HEADER_CLASS} {
        border-bottom: none !important;
    }
`;

// Templates reference the logo through {{root_template_path_logo}}, which Twig
// has already expanded into the deployment's base URL by the time we see the
// markup, so match on the file name rather than the placeholder.
const DHS_LOGO_MARKER = 'dhslogo.png';

const hasDhsLetterhead = html => typeof html === 'string' && html.includes(DHS_LOGO_MARKER);

const applyOnePageBlockFix = async function (page) {
    await page.addStyleTag({ content: onePageBlockFix });
    await page.evaluate((selector, breakClass) => {
        // Break before every block except the first: the first one continues
        // the normal flow, so no leading blank page is produced. Document order
        // is used rather than a sibling selector because the blocks are split
        // across sibling .clsMain wrappers in some templates.
        Array.from(document.querySelectorAll(selector))
            .slice(1)
            .forEach(block => block.classList.add(breakClass));
    }, ONE_PAGE_BLOCK, PAGE_BREAK_CLASS);
};

const PDF_TIMEOUT_MS = Number(process.env.PDF_TIMEOUT_MS) || 5 * 60 * 1000;
const SET_CONTENT_TIMEOUT_MS = Number(process.env.PDF_SETCONTENT_TIMEOUT_MS) || 30 * 1000;
const FONTS_READY_TIMEOUT_MS = Number(process.env.PDF_FONTS_TIMEOUT_MS) || 10 * 1000;

let browserPromise = null;

const launchBrowser = function () {
    return puppeteer.launch({
        headless: true,
        protocolTimeout: PDF_TIMEOUT_MS + 60 * 1000,
        args: [
            "--no-sandbox",
            "--disable-setuid-sandbox",
            "--disable-gpu",
            "--disable-dev-shm-usage"
        ]
    });
};

let printQueue = Promise.resolve();

const runExclusivePrint = function (printFn) {
    const result = printQueue.then(printFn, printFn);
    printQueue = result.then(() => undefined, () => undefined);
    return result;
};

const getBrowser = async function () {
    if (!browserPromise) {
        browserPromise = launchBrowser().then(browser => {
            browser.on('disconnected', () => {
                browserPromise = null;
            });
            return browser;
        }).catch(err => {
            browserPromise = null;
            throw err;
        });
    }
    return browserPromise;
};

const fetchUrlContent = async function (url) {
    if (!url || typeof url !== 'string') {
        return '';
    }
    try {
        const response = await axios.get(url, { timeout: 15000, responseType: 'text' });
        return typeof response.data === 'string' ? response.data : String(response.data);
    } catch (err) {
        LOGGER.error('PDF Error: failed to fetch resource ' + url, err.message);
        return '';
    }
};

const DEFAULT_MARGIN = '10mm';

const translateMargin = options => ({
    top: options['margin-top'] || DEFAULT_MARGIN,
    bottom: options['margin-bottom'] || DEFAULT_MARGIN,
    left: options['margin-left'] || DEFAULT_MARGIN,
    right: options['margin-right'] || DEFAULT_MARGIN
});

const translateLandscape = options => {
    if (typeof options.landscape === 'boolean') {
        return options.landscape;
    }
    if (options.orientation) {
        return String(options.orientation).toLowerCase() === 'landscape';
    }
    return undefined;
};

const resolveHeaderFooter = options => Promise.all([
    options['header-html'] ? getCleanFooterTemplate(options['header-html']) : '',
    options['footer-html'] ? getCleanFooterTemplate(options['footer-html']) : ''
]);

const translateOptions = async function (css, options = {}) {
    const inlineCss = /^https?:\/\//i.test(css) ? await fetchUrlContent(css) : (css || '');
    const userStyleSheet = await fetchUrlContent(options['user-style-sheet']);

    const addCss = `${inlineCss}
            ${userStyleSheet}
            ${bootstrapStackColumns}
            ${tableLayoutFix}
            body, p, td, th, div {
                font-size: 11px !important;
                font-family: 'Open Sans', sans-serif;
            }
            ${compactSpacing}`;

    const pdfOptions = {
        printBackground: true,
        format: options.pageSize || options.format || 'A4',
        margin: translateMargin(options),
        timeout: options.timeout !== undefined ? options.timeout : PDF_TIMEOUT_MS
    };

    const landscape = translateLandscape(options);
    if (landscape !== undefined) {
        pdfOptions.landscape = landscape;
    }

    const [headerHtml, footerHtml] = await resolveHeaderFooter(options);
    if (headerHtml || footerHtml) {
        pdfOptions.displayHeaderFooter = true;
        pdfOptions.headerTemplate = `${headerHtml}`;
        pdfOptions.footerTemplate = `${footerHtml}`;
    }

    return { pdfOptions, addCss };
};

const FOOTER_INSET_X = '72px';

async function getCleanFooterTemplate(url) {
    if (!url) return '<span></span>';
    try {
        const response = await fetch(url);
        const htmlString = await response.text();

        const bodyMatch = htmlString.match(/<body[^>]*>([\s\S]*)<\/body>/i);
        let content = bodyMatch ? bodyMatch[1] : htmlString;

        const styleMatches = htmlString.match(/<style[^>]*>([\s\S]*?)<\/style>/gi);
        const styles = styleMatches ? styleMatches.join('\n') : '';

        content = content
            .replace(/<link[^>]*>/gi, '')
            .replace(/<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi, '');

        return `
            ${styles}
            <style>
                .footer-wrapper { padding-top: 0 !important; margin-top: 0 !important; }
                .footer { position: static !important; }
                .footer-wrapper > *:first-child,
                .footer > *:first-child { margin-top: 0 !important; }
            </style>
            <div style="font-size: 10px !important; width: 100%; margin: 0 ${FOOTER_INSET_X}; padding: 0; -webkit-print-color-adjust: exact;">
                ${content}
            </div>
        `;
    } catch (error) {
        LOGGER.error('Error processing footer URL:', error.message);
        return '<span></span>';
    }
}

const pdfGenerator = function (data, template, css, options = {}) {
    return runExclusivePrint(async () => {
        let page = null;
        try {
            const browser = await getBrowser();
            page = await browser.newPage();

            await page.emulateMediaType('screen');

            const { pdfOptions, addCss } = await translateOptions(css, options);
            const renderedHTML = `${twig({ data: template }).render(data)}`;
            
            try {
                await page.setContent(renderedHTML, {
                    waitUntil: 'load',
                    timeout: SET_CONTENT_TIMEOUT_MS
                });
            } catch (err) {
                LOGGER.warn('PDF: page load did not complete, printing anyway:', err.message);
            }

            await page.addStyleTag({ content: addCss });

            // After addCss: it carries /style.css, whose hiding rule this undoes.
            await page.addStyleTag({ content: bareControlFix });
            await page.addStyleTag({ content: checkboxMarkFix });

            if (hasDhsLetterhead(renderedHTML)) {
                await applyOnePageBlockFix(page);
            }

            // 'load' does not cover web fonts: font files are fetched during
            // layout and can resolve after the load event.
            try {
                await page.evaluate(
                    timeout => Promise.race([
                        document.fonts.ready,
                        new Promise(resolve => setTimeout(resolve, timeout))
                    ]),
                    FONTS_READY_TIMEOUT_MS
                );
            } catch (err) {
                LOGGER.warn('PDF: font loading wait failed:', err.message);
            }

            await page.evaluate(() => {
                document.querySelectorAll('table').forEach(table => {
                    if (table.tHead) return;
                    const firstRow = table.querySelector('tr');
                    if (!firstRow) return;
                    // Must be inlined: page.evaluate() serializes this callback and
                    // runs it in Chrome, where Node-scope helpers do not exist -
                    // calling one throws "ReferenceError: ... is not defined".
                    const cells = Array.from(firstRow.children);
                    if (!cells.length || !cells.every(c => c.tagName === 'TH')) {
                        return;
                    }
                    const thead = table.createTHead();
                    thead.appendChild(firstRow);
                });
            });

            return await page.pdf(pdfOptions);

        } catch (error) {
            LOGGER.error("PDF Error:", error);
            throw error;
        } finally {
            if (page) {
                await page.close().catch(err => LOGGER.debug('PDF page close failed:', err.message));
            }
        }
    });
};

module.exports = pdfGenerator;