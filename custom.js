const video = document.querySelector('video');
if (video) {
    // Options for the intersection observer
    const options = {
      root: null,
      rootMargin: '0px',
      threshold: .2
    };

    // Intersection Observer callback function
    const callback = (entries, observer) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          video.play();
          //video.style.transform = 'scale(1)'; // Example rescaling value
        } else {
            console.log(`Scrolling`)
          video.pause();
          //video.style.transform = 'scale(.4)';
        }
      });
    };

    // Create intersection observer
    const observer = new IntersectionObserver(callback, options);

    // Observe the video
    observer.observe(video);

    const viewportHeight = window.innerHeight;
    const viewportWidth = window.innerWidth;

    window.addEventListener('scroll', function() {
      const scrollPosition = window.scrollY;
      let scale = 1 - (scrollPosition / (2 * viewportHeight)); // Scale factor
      scale = Math.max(scale, 0.5); // Ensure scale doesn't go below 0.5

      // Calculate translate position in percentage
      const translateX = -50 + (1 - scale) * 50;
      // Set transform and translate
      video.style.top = scrollPosition >= viewportHeight/2 ? '270px' : '50%'; 
      video.style.transform = `translate(${translateX}%, -50%) scale(${scale})`;
    });
}
