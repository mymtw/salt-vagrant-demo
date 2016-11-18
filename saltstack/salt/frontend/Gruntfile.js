module.exports = function(grunt) {

    grunt.initConfig({
        ngconstant: {
            options: {
                dest: 'config.js',
                wrap: '"use strict";\n\n{%= __ngModule %}',
                space: '  ',
                name: 'config'
            },
            dist: {
                constants: 'config.json'
            }
        },

    });

    grunt.loadNpmTasks('grunt-ng-constant');
};
