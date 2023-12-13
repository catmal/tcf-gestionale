const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {

    colors: {
      light: {
        DEFAULT: '#ffffff',
      },
      gray: {
        DEFAULT: '#385f71',
        dark: '#2b4162',
      },
      green: {
        DEFAULT: '#99d17b',
        dark: '#588b8b'
      },
      blue: {
        DEFAULT: '#00a7e1',
      },
      red: {
        DEFAULT: '#fb3640',
      }

    },
    extend: {

      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
