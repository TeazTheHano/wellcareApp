// Query elements
document.addEventListener("DOMContentLoaded", () => {
  try {
    console.log("DOM fully loaded and parsed");
    let elements = {
      header: document.querySelector("header"),
      main: document.querySelector("main"),
      footer: document.querySelector("footer"),
      // Navigation elements
      navLinks: document.querySelectorAll("header nav a"),
      mobileHamburger: document.querySelector("header button[aria-label='Toggle menu']"),
      mobileNavMenu: document.querySelector("#mobileMenu"),
      mobileNavLinks: document.querySelectorAll("#mobileMenu nav a"),
      mobileNavMenuClose: document.querySelector("#mobileMenu button[aria-label='Close menu']"),
      // Contact toggle
      contactToggle: document.querySelectorAll("button[aria-label='Open Contact']"),
      faqButtons: document.querySelectorAll(".faq-button"),
      registerForm: document.querySelector("#registerForm"),
      // Slider
      heroSlides: document.querySelectorAll(".news-hero-slide"),
      heroPrevBtn: document.querySelector("#newsHeroPrev"),
      heroNextBtn: document.querySelector("#newsHeroNext"),
      // Carousel
      carousel: document.querySelector("#privilegesCarousel"),
      prevBtn: document.querySelector("#privilegesCarouselPrev"),
      nextBtn: document.querySelector("#privilegesCarouselNext"),
      // Language selector
      langBtn: document.querySelector("#langBtn"),
      langDropdown: document.querySelector("#langDropdown"),
      currentLang: document.querySelector("#currentLang"),
      langChevron: document.querySelector("#langChevron"),
      langItems: document.querySelectorAll(".lang-item"),
      // Mobile Language selector
      langBtnMobile: document.querySelector("#langBtnMobile"),
      langDropdownMobile: document.querySelector("#langDropdownMobile"),
      currentLangMobile: document.querySelector("#currentLangMobile"),
      langChevronMobile: document.querySelector("#langChevronMobile"),
      langItemsMobile: document.querySelectorAll(".lang-item-mobile"),
    };

    // Check current route
    function checkCurrentRoute() {
      const currentPath = window.location.pathname;
      const currentFile = currentPath.split("/").pop() || "";
      return currentFile;
    }

    // Update UI for active nav item based on route
    function UI_navItemActiveByRoute(currentFile) {
      const activeUI = (item, underline) => {
        item.className = item.className.replace(
          /text-gray-700 hover:text-primary font-light/g,
          "text-primary font-medium"
        );
        if (underline) {
          underline.className = underline.className.replace(
            /w-0 group-hover:w-full/g,
            "w-full"
          );
        }
      };

      const deActiveUI = (item, underline) => {
        item.className = item.className.replace(
          /text-primary font-medium/g,
          "text-gray-700 hover:text-primary font-light"
        );
        if (underline) {
          underline.className = underline.className.replace(
            /w-full/g,
            "w-0 group-hover:w-full"
          );
        }
      };

      const activateNavItem = (item, isActive) => {
        const underline = item.querySelector("span");
        isActive ? activeUI(item, underline) : deActiveUI(item, underline);
      };

      const activeNavItem = Array.from(elements.navLinks).find(link => {
        const linkFile = link.getAttribute("href").split("/").pop() || "";
        return linkFile === currentFile;
      });

      // Desktop nav links
      elements.navLinks.forEach(link => {
        activateNavItem(link, link === activeNavItem);
      });

      // Mobile nav links
      elements.mobileNavLinks.forEach(link => {
        link.className = "block px-6 py-4 rounded-2xl text-lg transition-all";
        const linkFile = link.getAttribute("href").split("/").pop() || "";
        const isActive = linkFile === currentFile;
        isActive ? link.classList.add("bg-primary/10", "text-primary", "font-medium") :
          link.classList.remove("bg-primary/10", "text-primary", "font-medium");
      });
    }
    // End of UI_navItemActiveByRoute

    // Toggle mobile menu
    function toggleMobileMenu(show) {
      elements.mobileNavMenu.classList.toggle("hidden", !show);
      document.body.classList.toggle("overflow-hidden", show);

      // Close mobile menu when clicking outside
      mobileMenu.addEventListener("click", (event) => {
        if (event.target === elements.mobileNavMenu && mobileMenu) {
          toggleMobileMenu(false);
        }
      });

      // Close mobile menu on ESC key
      document.addEventListener("keydown", (event) => {
        if (event.key === "Escape" && mobileMenu) {
          toggleMobileMenu(false);
        }
      });
    }

    // Language section
    function toggleLangDropdown(isMobile = false) {
      const langBtn = isMobile ? elements.langBtnMobile : elements.langBtn;
      const langDropdown = isMobile ? elements.langDropdownMobile : elements.langDropdown;
      const langChevron = isMobile ? elements.langChevronMobile : elements.langChevron;

      langDropdown.classList.toggle("hidden");
      langChevron.classList.toggle("rotate-180");

      // Close dropdown when clicking outside
      document.addEventListener("click", (event) => {
        if (!langBtn.contains(event.target) && !langDropdown.contains(event.target)) {
          langDropdown.classList.add("hidden");
          langChevron.classList.remove("rotate-180");
        }
      });

      // Close dropdown on ESC key
      document.addEventListener("keydown", (event) => {
        if (event.key === "Escape") {
          langDropdown.classList.add("hidden");
          langChevron.classList.remove("rotate-180");
        }
      });
    }
    // End of Language section

    function mountLangEvent() {
      elements.langBtn.addEventListener("click", () => toggleLangDropdown(false));
      elements.langBtnMobile.addEventListener("click", () => toggleLangDropdown(true));

      elements.langItems.forEach(item => {
        item.addEventListener("click", () => {
          const selectedLang = item.textContent.trim();
          elements.currentLang.textContent = selectedLang;
          toggleLangDropdown(false);
        });
      });

      elements.langItemsMobile.forEach(item => {
        item.addEventListener("click", () => {
          const selectedLang = item.textContent.trim();
          elements.currentLangMobile.textContent = selectedLang;
          toggleLangDropdown(true);
        });
      });
    }

    function initLangSetup() {
      var pathLang = window.location.pathname;
      if (pathLang.includes("EN")) {
        elements.currentLang.textContent = "EN";
        elements.currentLangMobile.textContent = "EN";
      } else if (pathLang.includes("VI")) {
        elements.currentLang.textContent = "VI";
        elements.currentLangMobile.textContent = "VI";
      }
    }

    // function faqFnc() {
    // function handleFaqClick(button) {
    //   const faqItem = button.closest(".faq-item");
    //   const faqContent = faqItem.querySelector(".faq-content");
    //   const faqIcon = faqItem.querySelector(".faq-icon svg");
    //   const isExpanded = button.getAttribute("aria-expanded") === "true";

    //   // Close all other FAQ items
    //   document.querySelectorAll(".faq-item").forEach(item => {
    //     if (item !== faqItem) {
    //       const otherContent = item.querySelector(".faq-content");
    //       const otherButton = item.querySelector(".faq-button");
    //       const otherIcon = item.querySelector(".faq-icon svg");
    //       otherContent.style.maxHeight = "0";
    //       otherButton.setAttribute("aria-expanded", "false");
    //       otherIcon.style.transform = "rotate(0deg)";
    //     }
    //   });

    //   // Toggle current FAQ item
    //   faqContent.style.maxHeight = isExpanded ? "0" : `${faqContent.scrollHeight}px`;
    //   button.setAttribute("aria-expanded", !isExpanded);
    //   faqIcon.style.transform = isExpanded ? "rotate(0deg)" : "rotate(180deg)";
    // }

    // elements.faqButtons.forEach(button => {
    //   button.addEventListener("click", () => handleFaqClick(button));
    // });
    // }
    // >>>>>>>>>>>>>>>>>>>> RUN FUNCTIONS <<<<<<<<<<<<<<<<<<

    // Initialize UI
    const currentFile = checkCurrentRoute();
    UI_navItemActiveByRoute(currentFile);
    initLangSetup();
    mountLangEvent();
    // faqFnc();

    // >>>>>>>>>>>>>>>>>>>> Mount event listeners here... <<<<<<<<<<<<<<<<<<
    elements.mobileHamburger.addEventListener("click", () => toggleMobileMenu(true));
    elements.mobileNavMenuClose.addEventListener("click", () => toggleMobileMenu(false));

  } catch (error) {
    console.log('ERR: ', error);
  }
});
