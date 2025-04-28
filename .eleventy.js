const yaml = require('js-yaml');

module.exports = function (config) {
  config.addDataExtension('yml', (contents) => {
    return yaml.load(contents);
  });
  config.addPassthroughCopy("src/styles");
  config.addPassthroughCopy("src/rolls/**/photos/*.jpg");

  // Настройка пагинации
  config.addCollection("pagedRolls", function(collectionApi) {
    return collectionApi.getFilteredByTag("roll").reverse();
  });

  return {
    dir: {
      includes: "includes",
      layouts: "layouts",
      input: "src",
      output: "dist",
      templateFormats: ["html", "md", "njk"],
      data: 'data',
    },
    dataTemplateEngine: 'njk',
    markdownTemplateEngine: 'njk',
    htmlTemplateEngine: 'njk',
    passthroughFileCopy: true,
    templateFormats: [
      'md', 'njk'
    ],
    pagination: {
      size: 3
    }
  };
};
