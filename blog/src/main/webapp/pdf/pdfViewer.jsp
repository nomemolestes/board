<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
 <head>
  <meta charset="UTF-8">
  <meta name="Generator" content="EditPlus®">
  <meta name="Author" content="">
  <meta name="Keywords" content="">
  <meta name="Description" content="">
  <title>Document</title>
<script src="./js/pdf.js"></script>
<script src="./js/pdf.worker.js"></script>
<script>
var url = '/formal_objection.pdf';
var pdfDoc = null,
    pageNum = 1,
    pageRendering = false,
    pageNumPending = null,
    scale = 0.8;
var canvas = null;
var ctx = null;
onload=function(){
    canvas = document.getElementById('the-canvas'),
    ctx = canvas.getContext('2d');
 
  document.getElementById('next').addEventListener('click', onNextPage);
 /**
  * Asynchronously downloads PDF.
  */
 pdfjsLib.getDocument(url).promise.then(function(pdfDoc_) {
   pdfDoc = pdfDoc_;
   document.getElementById('page_count').textContent = pdfDoc.numPages;

   // Initial/first page rendering
   renderPage(pageNum);
 });

}

$ git clone https://github.com/mozilla/pdf.js.git
	$ cd pdf.js

/**
 * Get page info from document, resize canvas accordingly, and render page.
 * @param num Page number.
 */
function renderPage(num) {
  pageRendering = true;
  // Using promise to fetch the page
  pdfDoc.getPage(num).then(function(page) {
    var viewport = page.getViewport({scale: 1.5});
    canvas.height = viewport.height;
    canvas.width = viewport.width;

    // Render PDF page into canvas context
    var renderContext = {
      canvasContext: ctx,
      viewport: viewport
    };
    var renderTask = page.render(renderContext);

    // Wait for rendering to finish
    renderTask.promise.then(function() {
      pageRendering = false;
      if (pageNumPending !== null) {
        // New page rendering is pending
        renderPage(pageNumPending);
        pageNumPending = null;
      }
    });
  });

  // Update page counters
  document.getElementById('page_num').textContent = num;
}

