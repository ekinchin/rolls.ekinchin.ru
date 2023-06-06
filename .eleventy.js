module.exports = function (config) {
  config.addPassthroughCopy("src/styles");
    config.addPassthroughCopy('src/rolls/**/*.(jpg)');
  return {
    dir: {
      includes: "includes",
      layouts: "layouts",
      input: "src",
      output: "dist",
      templateFormats: ["html", "md", "njk"],
      data: 'data',
    },
  };
};
