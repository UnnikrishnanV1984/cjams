--CDM-10517 - Add other person in the contact notes

update progressnote set otherpersonname = 'Nicole, nurse at Sheppard Pratt.', updatedby='CM-10517', updatedon = now() where progressnoteid in ('8bafb36e-8fa1-4ab1-94ff-de7f43041b5f','75ed9859-f879-468a-9fb2-51d063245690');
