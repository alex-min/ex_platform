/* eslint-env jest */

import AutoClearNotification from "../../assets/js/autoclear-notification.js";
import { createElementFromHTML, ViewHookTest } from "./view-hook-test.js";

describe("AutoClearNotification", () => {
    jest.useFakeTimers();

    test("clears notifications", () => {
        const element = createElementFromHTML("<div><div><div phx-value-key=\"alert\">content</div></div></div>");
        const hook =  new ViewHookTest(AutoClearNotification, element.firstChild.firstChild);
        hook.trigger("mounted");
        jest.runAllTimers();
        expect(element.className).toStrictEqual("animate__animated animate__fadeOutRight");
        expect(hook.events).toStrictEqual([{
            target: "lv:clear-flash",
            event: "alert",
            payload: undefined
        }]);
    });
});