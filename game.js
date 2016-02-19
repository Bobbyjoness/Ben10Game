
var Module;

if (typeof Module === 'undefined') Module = eval('(function() { try { return Module || {} } catch(e) { return {} } })()');

if (!Module.expectedDataFileDownloads) {
  Module.expectedDataFileDownloads = 0;
  Module.finishedDataFileDownloads = 0;
}
Module.expectedDataFileDownloads++;
(function() {
 var loadPackage = function(metadata) {

    var PACKAGE_PATH;
    if (typeof window === 'object') {
      PACKAGE_PATH = window['encodeURIComponent'](window.location.pathname.toString().substring(0, window.location.pathname.toString().lastIndexOf('/')) + '/');
    } else if (typeof location !== 'undefined') {
      // worker
      PACKAGE_PATH = encodeURIComponent(location.pathname.toString().substring(0, location.pathname.toString().lastIndexOf('/')) + '/');
    } else {
      throw 'using preloaded data can only be done on a web page or in a web worker';
    }
    var PACKAGE_NAME = 'game.data';
    var REMOTE_PACKAGE_BASE = 'game.data';
    if (typeof Module['locateFilePackage'] === 'function' && !Module['locateFile']) {
      Module['locateFile'] = Module['locateFilePackage'];
      Module.printErr('warning: you defined Module.locateFilePackage, that has been renamed to Module.locateFile (using your locateFilePackage for now)');
    }
    var REMOTE_PACKAGE_NAME = typeof Module['locateFile'] === 'function' ?
                              Module['locateFile'](REMOTE_PACKAGE_BASE) :
                              ((Module['filePackagePrefixURL'] || '') + REMOTE_PACKAGE_BASE);
  
    var REMOTE_PACKAGE_SIZE = metadata.remote_package_size;
    var PACKAGE_UUID = metadata.package_uuid;
  
    function fetchRemotePackage(packageName, packageSize, callback, errback) {
      var xhr = new XMLHttpRequest();
      xhr.open('GET', packageName, true);
      xhr.responseType = 'arraybuffer';
      xhr.onprogress = function(event) {
        var url = packageName;
        var size = packageSize;
        if (event.total) size = event.total;
        if (event.loaded) {
          if (!xhr.addedTotal) {
            xhr.addedTotal = true;
            if (!Module.dataFileDownloads) Module.dataFileDownloads = {};
            Module.dataFileDownloads[url] = {
              loaded: event.loaded,
              total: size
            };
          } else {
            Module.dataFileDownloads[url].loaded = event.loaded;
          }
          var total = 0;
          var loaded = 0;
          var num = 0;
          for (var download in Module.dataFileDownloads) {
          var data = Module.dataFileDownloads[download];
            total += data.total;
            loaded += data.loaded;
            num++;
          }
          total = Math.ceil(total * Module.expectedDataFileDownloads/num);
          if (Module['setStatus']) Module['setStatus']('Downloading data... (' + loaded + '/' + total + ')');
        } else if (!Module.dataFileDownloads) {
          if (Module['setStatus']) Module['setStatus']('Downloading data...');
        }
      };
      xhr.onload = function(event) {
        var packageData = xhr.response;
        callback(packageData);
      };
      xhr.send(null);
    };

    function handleError(error) {
      console.error('package error:', error);
    };
  
      var fetched = null, fetchedCallback = null;
      fetchRemotePackage(REMOTE_PACKAGE_NAME, REMOTE_PACKAGE_SIZE, function(data) {
        if (fetchedCallback) {
          fetchedCallback(data);
          fetchedCallback = null;
        } else {
          fetched = data;
        }
      }, handleError);
    
  function runWithFS() {

    function assert(check, msg) {
      if (!check) throw msg + new Error().stack;
    }
Module['FS_createPath']('/', 'assets', true, true);
Module['FS_createPath']('/', 'classes', true, true);
Module['FS_createPath']('/', 'libs', true, true);
Module['FS_createPath']('/libs', 'anim8', true, true);
Module['FS_createPath']('/libs/anim8', 'spec', true, true);
Module['FS_createPath']('/libs/anim8/spec', 'anim8', true, true);
Module['FS_createPath']('/libs', 'bump', true, true);
Module['FS_createPath']('/libs/bump', 'img', true, true);
Module['FS_createPath']('/libs/bump', 'rockspecs', true, true);
Module['FS_createPath']('/libs/bump', 'spec', true, true);
Module['FS_createPath']('/libs', 'hump', true, true);
Module['FS_createPath']('/libs/hump', 'docs', true, true);
Module['FS_createPath']('/libs/hump/docs', '_static', true, true);
Module['FS_createPath']('/libs', 'STI', true, true);
Module['FS_createPath']('/libs/STI', 'plugins', true, true);
Module['FS_createPath']('/', 'maps', true, true);
Module['FS_createPath']('/', 'states', true, true);

    function DataRequest(start, end, crunched, audio) {
      this.start = start;
      this.end = end;
      this.crunched = crunched;
      this.audio = audio;
    }
    DataRequest.prototype = {
      requests: {},
      open: function(mode, name) {
        this.name = name;
        this.requests[name] = this;
        Module['addRunDependency']('fp ' + this.name);
      },
      send: function() {},
      onload: function() {
        var byteArray = this.byteArray.subarray(this.start, this.end);

          this.finish(byteArray);

      },
      finish: function(byteArray) {
        var that = this;

        Module['FS_createDataFile'](this.name, null, byteArray, true, true, true); // canOwn this data in the filesystem, it is a slide into the heap that will never change
        Module['removeRunDependency']('fp ' + that.name);

        this.requests[this.name] = null;
      },
    };

        var files = metadata.files;
        for (i = 0; i < files.length; ++i) {
          new DataRequest(files[i].start, files[i].end, files[i].crunched, files[i].audio).open('GET', files[i].filename);
        }

  
    function processPackageData(arrayBuffer) {
      Module.finishedDataFileDownloads++;
      assert(arrayBuffer, 'Loading data file failed.');
      assert(arrayBuffer instanceof ArrayBuffer, 'bad input to processPackageData');
      var byteArray = new Uint8Array(arrayBuffer);
      var curr;
      
        // copy the entire loaded file into a spot in the heap. Files will refer to slices in that. They cannot be freed though
        // (we may be allocating before malloc is ready, during startup).
        if (Module['SPLIT_MEMORY']) Module.printErr('warning: you should run the file packager with --no-heap-copy when SPLIT_MEMORY is used, otherwise copying into the heap may fail due to the splitting');
        var ptr = Module['getMemory'](byteArray.length);
        Module['HEAPU8'].set(byteArray, ptr);
        DataRequest.prototype.byteArray = Module['HEAPU8'].subarray(ptr, ptr+byteArray.length);
  
          var files = metadata.files;
          for (i = 0; i < files.length; ++i) {
            DataRequest.prototype.requests[files[i].filename].onload();
          }
              Module['removeRunDependency']('datafile_game.data');

    };
    Module['addRunDependency']('datafile_game.data');
  
    if (!Module.preloadResults) Module.preloadResults = {};
  
      Module.preloadResults[PACKAGE_NAME] = {fromCache: false};
      if (fetched) {
        processPackageData(fetched);
        fetched = null;
      } else {
        fetchedCallback = processPackageData;
      }
    
  }
  if (Module['calledRun']) {
    runWithFS();
  } else {
    if (!Module['preRun']) Module['preRun'] = [];
    Module["preRun"].push(runWithFS); // FS is not initialized yet, wait for it
  }

 }
 loadPackage({"files": [{"audio": 0, "start": 0, "crunched": 0, "end": 3493, "filename": "/conf.lua"}, {"audio": 0, "start": 3493, "crunched": 0, "end": 3748, "filename": "/main.lua"}, {"audio": 0, "start": 3748, "crunched": 0, "end": 75685, "filename": "/assets/spritesheet.png"}, {"audio": 0, "start": 75685, "crunched": 0, "end": 77650, "filename": "/classes/player.lua"}, {"audio": 0, "start": 77650, "crunched": 0, "end": 78371, "filename": "/libs/anim8/.travis.yml"}, {"audio": 0, "start": 78371, "crunched": 0, "end": 86863, "filename": "/libs/anim8/anim8.lua"}, {"audio": 0, "start": 86863, "crunched": 0, "end": 87346, "filename": "/libs/anim8/CHANGELOG.md"}, {"audio": 0, "start": 87346, "crunched": 0, "end": 88410, "filename": "/libs/anim8/MIT-LICENSE.txt"}, {"audio": 0, "start": 88410, "crunched": 0, "end": 98716, "filename": "/libs/anim8/README.md"}, {"audio": 0, "start": 98716, "crunched": 0, "end": 99419, "filename": "/libs/anim8/spec/love-mocks.lua"}, {"audio": 0, "start": 99419, "crunched": 0, "end": 108334, "filename": "/libs/anim8/spec/anim8/animation_spec.lua"}, {"audio": 0, "start": 108334, "crunched": 0, "end": 113174, "filename": "/libs/anim8/spec/anim8/grid_spec.lua"}, {"audio": 0, "start": 113174, "crunched": 0, "end": 113183, "filename": "/libs/bump/.gitignore"}, {"audio": 0, "start": 113183, "crunched": 0, "end": 113906, "filename": "/libs/bump/.travis.yml"}, {"audio": 0, "start": 113906, "crunched": 0, "end": 135227, "filename": "/libs/bump/bump.lua"}, {"audio": 0, "start": 135227, "crunched": 0, "end": 137251, "filename": "/libs/bump/CHANGELOG.md"}, {"audio": 0, "start": 137251, "crunched": 0, "end": 138315, "filename": "/libs/bump/MIT-LICENSE.txt"}, {"audio": 0, "start": 138315, "crunched": 0, "end": 165106, "filename": "/libs/bump/README.md"}, {"audio": 0, "start": 165106, "crunched": 0, "end": 301929, "filename": "/libs/bump/img/bounce.png"}, {"audio": 0, "start": 301929, "crunched": 0, "end": 397571, "filename": "/libs/bump/img/cross.png"}, {"audio": 0, "start": 397571, "crunched": 0, "end": 518188, "filename": "/libs/bump/img/responses.odg"}, {"audio": 0, "start": 518188, "crunched": 0, "end": 790387, "filename": "/libs/bump/img/slide.png"}, {"audio": 0, "start": 790387, "crunched": 0, "end": 1005879, "filename": "/libs/bump/img/touch.png"}, {"audio": 0, "start": 1005879, "crunched": 0, "end": 1006459, "filename": "/libs/bump/rockspecs/bump-3.1.5-1.rockspec"}, {"audio": 0, "start": 1006459, "crunched": 0, "end": 1007049, "filename": "/libs/bump/spec/bump_spec.lua"}, {"audio": 0, "start": 1007049, "crunched": 0, "end": 1009233, "filename": "/libs/bump/spec/rect_spec.lua"}, {"audio": 0, "start": 1009233, "crunched": 0, "end": 1015382, "filename": "/libs/bump/spec/responses_spec.lua"}, {"audio": 0, "start": 1015382, "crunched": 0, "end": 1029564, "filename": "/libs/bump/spec/World_spec.lua"}, {"audio": 0, "start": 1029564, "crunched": 0, "end": 1034909, "filename": "/libs/hump/camera.lua"}, {"audio": 0, "start": 1034909, "crunched": 0, "end": 1037933, "filename": "/libs/hump/class.lua"}, {"audio": 0, "start": 1037933, "crunched": 0, "end": 1041467, "filename": "/libs/hump/gamestate.lua"}, {"audio": 0, "start": 1041467, "crunched": 0, "end": 1043686, "filename": "/libs/hump/README.md"}, {"audio": 0, "start": 1043686, "crunched": 0, "end": 1046441, "filename": "/libs/hump/signal.lua"}, {"audio": 0, "start": 1046441, "crunched": 0, "end": 1052796, "filename": "/libs/hump/timer.lua"}, {"audio": 0, "start": 1052796, "crunched": 0, "end": 1056356, "filename": "/libs/hump/vector-light.lua"}, {"audio": 0, "start": 1056356, "crunched": 0, "end": 1061675, "filename": "/libs/hump/vector.lua"}, {"audio": 0, "start": 1061675, "crunched": 0, "end": 1076069, "filename": "/libs/hump/docs/camera.rst"}, {"audio": 0, "start": 1076069, "crunched": 0, "end": 1085130, "filename": "/libs/hump/docs/class.rst"}, {"audio": 0, "start": 1085130, "crunched": 0, "end": 1094466, "filename": "/libs/hump/docs/conf.py"}, {"audio": 0, "start": 1094466, "crunched": 0, "end": 1103590, "filename": "/libs/hump/docs/gamestate.rst"}, {"audio": 0, "start": 1103590, "crunched": 0, "end": 1104892, "filename": "/libs/hump/docs/index.rst"}, {"audio": 0, "start": 1104892, "crunched": 0, "end": 1106197, "filename": "/libs/hump/docs/license.rst"}, {"audio": 0, "start": 1106197, "crunched": 0, "end": 1113598, "filename": "/libs/hump/docs/Makefile"}, {"audio": 0, "start": 1113598, "crunched": 0, "end": 1117872, "filename": "/libs/hump/docs/signal.rst"}, {"audio": 0, "start": 1117872, "crunched": 0, "end": 1130415, "filename": "/libs/hump/docs/timer.rst"}, {"audio": 0, "start": 1130415, "crunched": 0, "end": 1139970, "filename": "/libs/hump/docs/vector-light.rst"}, {"audio": 0, "start": 1139970, "crunched": 0, "end": 1150120, "filename": "/libs/hump/docs/vector.rst"}, {"audio": 0, "start": 1150120, "crunched": 0, "end": 1157094, "filename": "/libs/hump/docs/_static/graph-tweens.js"}, {"audio": 0, "start": 1157094, "crunched": 0, "end": 1259930, "filename": "/libs/hump/docs/_static/in-out-interpolators.png"}, {"audio": 0, "start": 1259930, "crunched": 0, "end": 1356694, "filename": "/libs/hump/docs/_static/interpolators.png"}, {"audio": 0, "start": 1356694, "crunched": 0, "end": 1412170, "filename": "/libs/hump/docs/_static/inv-interpolators.png"}, {"audio": 0, "start": 1412170, "crunched": 0, "end": 1425595, "filename": "/libs/hump/docs/_static/vector-cross.png"}, {"audio": 0, "start": 1425595, "crunched": 0, "end": 1438701, "filename": "/libs/hump/docs/_static/vector-mirrorOn.png"}, {"audio": 0, "start": 1438701, "crunched": 0, "end": 1452469, "filename": "/libs/hump/docs/_static/vector-perpendicular.png"}, {"audio": 0, "start": 1452469, "crunched": 0, "end": 1482376, "filename": "/libs/hump/docs/_static/vector-projectOn.png"}, {"audio": 0, "start": 1482376, "crunched": 0, "end": 1495058, "filename": "/libs/hump/docs/_static/vector-rotated.png"}, {"audio": 0, "start": 1495058, "crunched": 0, "end": 1506043, "filename": "/libs/STI/CHANGELOG.md"}, {"audio": 0, "start": 1506043, "crunched": 0, "end": 1507366, "filename": "/libs/STI/init.lua"}, {"audio": 0, "start": 1507366, "crunched": 0, "end": 1508668, "filename": "/libs/STI/LICENSE.md"}, {"audio": 0, "start": 1508668, "crunched": 0, "end": 1545438, "filename": "/libs/STI/map.lua"}, {"audio": 0, "start": 1545438, "crunched": 0, "end": 1547939, "filename": "/libs/STI/README.md"}, {"audio": 0, "start": 1547939, "crunched": 0, "end": 1557108, "filename": "/libs/STI/plugins/box2d.lua"}, {"audio": 0, "start": 1557108, "crunched": 0, "end": 1560706, "filename": "/libs/STI/plugins/bump.lua"}, {"audio": 0, "start": 1560706, "crunched": 0, "end": 1562253, "filename": "/maps/map1.lua"}, {"audio": 0, "start": 1562253, "crunched": 0, "end": 1563094, "filename": "/maps/map1.tmx"}, {"audio": 0, "start": 1563094, "crunched": 0, "end": 1565006, "filename": "/states/play.lua"}], "remote_package_size": 1565006, "package_uuid": "0dfaa8b0-5ac2-48bb-b7d2-2555d54da67a"});

})();
