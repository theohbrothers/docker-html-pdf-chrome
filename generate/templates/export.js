const htmlPdf = require('html-pdf-chrome');

// Convert html to .pdf
var url = 'http://localhost';
if ('URL' in process.env) {
  url = process.env.URL;
}
var pdfFile = 'export.pdf';
if ('PDF_FILE' in process.env) {
  pdfFile = process.env.PDF_FILE;
}
const options = {
  port: 9222, // port Chrome is listening on
};
console.log(`Converting url '${url}' to: ${pdfFile}`);
const pdf = htmlPdf.create(url, options).then((pdf) => {
  pdf.toFile(pdfFile)
  console.log('Done.');
});
