///<reference path="../typings/jasmine/jasmine.d.ts"/>
import {MyClass} from '../src/MyClass';

describe('MyClass', () => {
    it('should say true', () => {
        var instance = new MyClass();
        expect(instance.sayTrue()).toBeTruthy();
    });
});