class ViewHookTest {
  constructor(hook, element) {
    this.el = element;
    this.__callbacks = hook;
    this.events = [];
    for(let key in this.__callbacks){ this[key] = this.__callbacks[key]; }
  }
  
  trigger(callbackName) {
    this.__callbacks[callbackName].bind(this)();
  }
  
  pushEvent(target, event, payload) {
    this.events.push({target, event, payload});
  }
  
  element() {
    return this.el;
  }
}
  
function createElementFromHTML(htmlString) {
  const div = document.createElement("div");
  div.innerHTML = htmlString.trim();
  return div.firstChild;
}
  
function renderHook(htmlString, hook) {
  const element = createElementFromHTML(htmlString);
  return new ViewHookTest(hook, element);
}
  
export { renderHook, ViewHookTest, createElementFromHTML };
  