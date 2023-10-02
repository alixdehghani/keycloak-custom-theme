const resourcesPath = document.getElementById('resources-path').value;
const localeLabel = document.getElementById('locale-label')?.value;
const timeout = function (s) {
  return new Promise(function (_, reject) {
    setTimeout(function () {
      reject(new Error(`Request took too long! Timeout after ${s} second`));
    }, s * 1000);
  });
};

const AJAX = async function (url, uploadData = undefined) {
  try {
    const fetchPro = uploadData
      ? fetch(url, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(uploadData),
      })
      : fetch(url);

    const res = await Promise.race([fetchPro, timeout(10)]);
    const data = await res.json();

    if (!res.ok) throw new Error(`${data.message} (${res.status})`);
    return data;
  } catch (err) {
    throw err;
  }
};

function ObsEmitter() {
  this.consumers = {};
}
ObsEmitter.prototype.next = function (value) {
  for (let key in this.consumers)
    this.consumers[key](value);
};
ObsEmitter.prototype.subscribe = function (callback) {    // This is necessary for "| async" in Angular
  if ("next" in callback)
    callback = callback.next;    // This is a kind of unique id
  let namespace = Math.random().toString(36).slice(2); this.consumers[namespace] = callback; return {
    unsubscribe: () => delete this.consumers[namespace]
  };
};

// function ObsCacher(value = undefined) {
//   this.value = value;
//   this.consumers = {};
// } ObsCacher.prototype.next = function (value) {
//   this.value = value;
//   for (let key in this.consumers)
//     this.consumers[key](value);
// }; ObsCacher.prototype.getValue = function () {
//   return this.value;
// }; ObsCacher.prototype.subscribe = function (callback) {    // This is necessary for "| async" in Angular
//   if ("next" in callback)
//     callback = callback.next; callback(this.value);    // This is a kind of unique id
//   let namespace = Math.random().toString(36).slice(2); this.consumers[namespace] = callback; return {
//     unsubscribe: () => delete this.consumers[namespace]
//   };
// };

// function ObsReplayer(bufferSize, expireTime) {
//   this.bufferSize = bufferSize || Number.MAX_SAFE_INTEGER;
//   this.expireTime = expireTime || Number.MAX_SAFE_INTEGER;
//   this.values = new DoublyLinkedList();
//   this.consumers = {};
// } ObsReplayer.prototype.next = function (value) {
//   this.values.push({
//     timestamp: (new Date()).getTime(),
//     value
//   });
//   for (let key in this.consumers)
//     this.consumers[key](
//       this.getValues()
//     );
// }; ObsReplayer.prototype.getValues = function () {
//   let collected = [];
//   let count = this.bufferSize;
//   this.values.traverseReverse((node) => {
//     if (!count) {
//       this.values.remove(node);
//       return;
//     }
//     let dt = (new Date()).getTime() - node.data.timestamp;
//     if (dt > this.expireTime) {
//       this.values.remove(node);
//       return;
//     }
//     collected.push(node.data.value);
//     count--;
//   });
//   return collected.reverse();
// }; ObsReplayer.prototype.subscribe = function (callback) {    // This is necessary for "| async" in Angular
//   if ("next" in callback) callback = callback.next;    // Run it with last values
//   callback(this.getValues());    // This is a kind of unique id
//   let namespace = Math.random().toString(36).slice(2); this.consumers[namespace] = callback; return {
//     unsubscribe: () => delete this.consumers[namespace]
//   };
// };

