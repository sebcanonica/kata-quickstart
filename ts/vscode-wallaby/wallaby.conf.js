module.exports = function (w) {

    return {
      files: [
        'src/*.ts'
      ],

      tests: [
        'test/*.spec.ts'
      ],

      env: {
          type: 'node'
      },

      testFramework: 'jasmine'
    };
  };