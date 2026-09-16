# CJAMS Server _(cjams-portal-api)_

> CJAMS Portal Server application

This application hosts server responsibilities for the CJAMS portal. It is written on [node.js](https://nodejs.org) and primary uses [loopback 3](https://loopback.io/doc/en/lb3/).

Responsibilities include:
* Hosting REST API and API documentation available at `:URL/explorer/`.
* Storing and managing document [templates](/documenttemplates).
* Managing and facilitating scheduled, batch, and chron jobs. *link and confirmation needed*
* Storing [uploaded files](/outputs/uploads). *confirmation needed*
* Facilitating database access.

## Install

After cloning the repository run `npm install`


## Getting Started

To start the server run `npm run start`