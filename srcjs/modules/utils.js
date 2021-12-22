export function elOrParentHasClass(element, classname) {
  if (
    typeof element.classList !== "undefined" &&
    element.classList.contains(classname)
  )
    return true;
  return (
    element.parentNode && elOrParentHasClass(element.parentNode, classname)
  );
}

export function validateEl(element, classname) {
  if (
    typeof element.classList !== "undefined" &&
    element.classList.contains(classname)
  )
    return element;
  return validateEl(element.parentNode, classname);
}

