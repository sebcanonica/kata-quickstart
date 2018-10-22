describe( 'MyClass', () => {

    it( 'should say true', () => {
        const object = new MyClass();
        expect(object.sayTrue()).toBe(true);
    } );
})