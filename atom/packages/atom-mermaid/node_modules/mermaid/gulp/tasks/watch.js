var browserify = require('browserify');
var source = require("vinyl-source-stream");
var watchify = require('watchify');
var livereload = require('gulp-livereload');
var gulpif = require('gulp-if');
var watch;

/*gulp.task('browserify-nowatch', function(){
  watch = false;
  browserifyShare();
});

gulp.task('browserify-watch', function(){
  watch = true;
  browserifyShare();
});

function browserifyShare(){
  var b = browserify({
    cache: {},
    packageCache: {},
    fullPaths: true
  });
  
  if(watch) {
    // if watch is enable, wrap this bundle inside watchify
    b = watchify(b);
    b.on('update', function(){
      bundleShare(b);
    });
  }
  
  b.add('./src/mermaid.js');
  bundleShare(b);
}

function bundleShare(b) {
  b.bundle()
    .pipe(source('share.js'))
    .pipe(gulp.dest('./dist'))
    .pipe(gulpif(watch, livereload()));
}

// define the browserify-watch as dependencies for this task
gulp.task('watch', ['browserify-watch'], function(){

  // Start live reload server
  livereload.listen(35729);
});
*/


var gulp = require('gulp');
 
var EXPRESS_PORT = 4000;
var EXPRESS_ROOT = __dirname+'/../..';
var LIVERELOAD_PORT = 35729;
 
// Let's make things more readable by
// encapsulating each part's setup
// in its own method
function startExpress() {
 
    console.log('Starting express: '+EXPRESS_ROOT);

  var express = require('express');
  var app = express();
  app.use(require('connect-livereload')());
  app.use(express.static(EXPRESS_ROOT));
  app.listen(EXPRESS_PORT);
}
 
// We'll need a reference to the tinylr
// object to send notifications of file changes
// further down
var lr;
function startLivereload() {
 
  lr = require('tiny-lr')();
  lr.listen(LIVERELOAD_PORT);
}
 
// Notifies livereload of changes detected
// by `gulp.watch()` 
// Don't forget to install `gulp-liverload` beforehand:
// `npm install gulp-livereload --save-dev`
function notifyLivereload2(event) {
   
  gulp.src(event.path, {read: false})
      .pipe(require('gulp-livereload')(lr));
}
 
// Notifies livereload of changes detected
// by `gulp.watch()` 
function notifyLivereload(event) {
 
 setTimeout(function(){
  // `gulp.watch()` events provide an absolute path
  // so we need to make it relative to the server root
  var fileName = require('path').relative(EXPRESS_ROOT, event.path);
  console.log('Detected change in '+fileName);
 
  lr.changed({
    body: {
      files: [fileName]
    }
  });
},5);
}

// Default task that will be run
// when no parameter is provided
// to gulp
gulp.task('watcher', function () {
  // watchify src/mermaid.js -o dist/mermaid.js

    var watchify   = require('watchify'),
        browserify = require('browserify'),
        bundler    = watchify(browserify('./src/mermaid.js', {
            cache: {},
            packageCache: {},
            fullPaths: true,
            debug: true
        }));

    function rebundle() {
        return bundler.bundle()
            .pipe(source('mermaid.js'))
            .pipe(gulp.dest('./dist'));
    }
    bundler.on('update', rebundle);
    // run any other gulp.watch tasks


  startExpress();
  startLivereload();
  gulp.watch('./test/**/*.html', notifyLivereload);
  gulp.watch('./dist/mermaid.js', notifyLivereload);

  return rebundle();
});

