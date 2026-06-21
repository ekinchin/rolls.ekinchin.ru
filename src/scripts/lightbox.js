(function () {
  function initGallery() {
    var links = Array.prototype.slice.call(document.querySelectorAll('[data-gallery-link]'));
    var lightbox = document.querySelector('[data-lightbox]');

    if (!links.length || !lightbox) {
      return;
    }

    var image = lightbox.querySelector('[data-lightbox-image]');
    var caption = lightbox.querySelector('[data-lightbox-caption]');
    var closeButton = lightbox.querySelector('[data-lightbox-close]');
    var prevButton = lightbox.querySelector('[data-lightbox-prev]');
    var nextButton = lightbox.querySelector('[data-lightbox-next]');
    var currentIndex = 0;

    function showPhoto(index) {
      currentIndex = (index + links.length) % links.length;

      var link = links[currentIndex];
      image.src = link.href;
      image.alt = link.querySelector('img').alt || '';
      caption.textContent = link.dataset.photoCaption || '';
    }

    function openLightbox(index) {
      showPhoto(index);
      lightbox.hidden = false;
      document.body.style.overflow = 'hidden';
      closeButton.focus();
    }

    function closeLightbox() {
      lightbox.hidden = true;
      document.body.style.overflow = '';
      image.removeAttribute('src');
      links[currentIndex].focus();
    }

    links.forEach(function (link, index) {
      link.addEventListener('click', function (event) {
        event.preventDefault();
        openLightbox(index);
      });
    });

    closeButton.addEventListener('click', closeLightbox);
    prevButton.addEventListener('click', function () {
      showPhoto(currentIndex - 1);
    });
    nextButton.addEventListener('click', function () {
      showPhoto(currentIndex + 1);
    });

    lightbox.addEventListener('click', function (event) {
      if (event.target === lightbox) {
        closeLightbox();
      }
    });

    document.addEventListener('keydown', function (event) {
      if (lightbox.hidden) {
        return;
      }

      if (event.key === 'Escape') {
        closeLightbox();
      }

      if (event.key === 'ArrowLeft') {
        showPhoto(currentIndex - 1);
      }

      if (event.key === 'ArrowRight') {
        showPhoto(currentIndex + 1);
      }
    });
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initGallery);
  } else {
    initGallery();
  }
})();
