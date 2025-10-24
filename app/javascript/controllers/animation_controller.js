import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["reveal", "navbar"]

  connect() {
    this.initScrollReveal()
    this.initSmoothScrolling()
    this.initNavbarScroll()
    this.initLazyLoading()
    this.initPerformanceOptimizations()
    this.initMobileMenu()
    
    // Reinitialize on Turbo navigation
    this.handleTurboNavigation()
  }

  // Handle Turbo navigation events
  handleTurboNavigation() {
    document.addEventListener('turbo:load', () => {
      // Small delay to ensure DOM is ready
      setTimeout(() => {
        this.initScrollReveal()
        this.initSmoothScrolling()
        this.initLazyLoading()
      }, 100)
    })
    
    document.addEventListener('turbo:render', () => {
      setTimeout(() => {
        this.initScrollReveal()
        this.initLazyLoading()
      }, 100)
    })
  }

  // Scroll Reveal Animation
  initScrollReveal() {
    const revealElements = document.querySelectorAll('.scroll-reveal:not(.observed)')
    
    if (revealElements.length === 0) return
    
    const observerOptions = {
      threshold: 0.1,
      rootMargin: '0px 0px -50px 0px'
    }

    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add('revealed')
          observer.unobserve(entry.target)
        }
      })
    }, observerOptions)

    revealElements.forEach(element => {
      element.classList.add('observed')
      observer.observe(element)
    })
  }

  // Smooth Scrolling for Anchor Links
  initSmoothScrolling() {
    const links = document.querySelectorAll('a[href^="#"]:not(.smooth-scroll-initialized)')
    
    links.forEach(link => {
      link.classList.add('smooth-scroll-initialized')
      link.addEventListener('click', (e) => {
        e.preventDefault()
        
        const targetId = link.getAttribute('href')
        const targetElement = document.querySelector(targetId)
        
        if (targetElement) {
          const offsetTop = targetElement.offsetTop - 80
          
          window.scrollTo({
            top: offsetTop,
            behavior: 'smooth'
          })
        }
      })
    })
  }

  // Navbar Scroll Effect
  initNavbarScroll() {
    const navbar = document.querySelector('.navbar')
    if (!navbar) return
    
    let lastScrollTop = 0
    
    window.addEventListener('scroll', () => {
      const scrollTop = window.pageYOffset || document.documentElement.scrollTop
      
      // Add shadow when scrolled
      if (scrollTop > 10) {
        navbar.classList.add('shadow-lg')
      } else {
        navbar.classList.remove('shadow-lg')
      }
      
      // Hide/show navbar on scroll
      if (scrollTop > lastScrollTop && scrollTop > 100) {
        navbar.style.transform = 'translateY(-100%)'
      } else {
        navbar.style.transform = 'translateY(0)'
      }
      
      lastScrollTop = scrollTop
    })
  }

  // Lazy Loading for Images
  initLazyLoading() {
    const images = document.querySelectorAll('img[data-src]:not(.lazy-loaded)')
    
    if (images.length === 0) return
    
    const imageObserver = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          const img = entry.target
          img.src = img.dataset.src
          img.classList.remove('skeleton')
          img.classList.add('lazy-loaded')
          imageObserver.unobserve(img)
        }
      })
    })
    
    images.forEach(img => {
      imageObserver.observe(img)
    })
  }

  // Performance Optimizations
  initPerformanceOptimizations() {
    const animatedElements = document.querySelectorAll('.card-hover, .btn-animated, .floating-element')
    
    animatedElements.forEach(element => {
      element.style.willChange = 'transform'
    })
    
    setTimeout(() => {
      animatedElements.forEach(element => {
        element.style.willChange = 'auto'
      })
    }, 3000)
  }

  // Parallax Effect for Hero Section
  initParallax() {
    const heroSection = document.querySelector('.hero-section')
    const floatingElements = document.querySelectorAll('.floating-circle, .floating-triangle')
    
    if (!heroSection) return
    
    window.addEventListener('scroll', () => {
      const scrolled = window.pageYOffset
      const rate = scrolled * -0.5
      
      floatingElements.forEach((element, index) => {
        const speed = (index + 1) * 0.3
        element.style.transform = `translateY(${rate * speed}px)`
      })
    })
  }

  // Form Interactions
  initFormInteractions() {
    const forms = document.querySelectorAll('form')
    
    forms.forEach(form => {
      const inputs = form.querySelectorAll('input, textarea, select')
      
      inputs.forEach(input => {
        input.addEventListener('focus', () => {
          input.parentElement.classList.add('focused')
        })
        
        input.addEventListener('blur', () => {
          if (!input.value) {
            input.parentElement.classList.remove('focused')
          }
        })
        
        input.addEventListener('input', () => {
          this.validateField(input)
        })
      })
    })
  }

  // Field Validation
  validateField(field) {
    const value = field.value.trim()
    const type = field.type
    const required = field.hasAttribute('required')
    
    let isValid = true
    let message = ''
    
    if (required && !value) {
      isValid = false
      message = 'Это поле обязательно для заполнения'
    } else if (type === 'email' && value) {
      const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
      if (!emailRegex.test(value)) {
        isValid = false
        message = 'Введите корректный email адрес'
      }
    }
    
    field.classList.toggle('is-valid', isValid && value)
    field.classList.toggle('is-invalid', !isValid)
    
    let errorElement = field.parentElement.querySelector('.invalid-feedback')
    if (!errorElement) {
      errorElement = document.createElement('div')
      errorElement.className = 'invalid-feedback'
      field.parentElement.appendChild(errorElement)
    }
    
    errorElement.textContent = message
  }

  // Utility methods
  showLoading(element) {
    element.classList.add('loading')
    element.disabled = true
    
    const originalText = element.textContent
    element.textContent = 'Загрузка...'
    
    return () => {
      element.classList.remove('loading')
      element.disabled = false
      element.textContent = originalText
    }
  }

  showNotification(message, type = 'success') {
    const notification = document.createElement('div')
    notification.className = `alert alert-${type} alert-dismissible fade show position-fixed`
    notification.style.cssText = 'top: 20px; right: 20px; z-index: 9999; min-width: 300px;'
    
    notification.innerHTML = `
      ${message}
      <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    `
    
    document.body.appendChild(notification)
    
    setTimeout(() => {
      if (notification.parentElement) {
        notification.remove()
      }
    }, 5000)
  }

  // Bootstrap 5 Mobile Menu with custom slide animation
  initMobileMenu() {
    const navbarCollapse = document.querySelector('#navbarNav')
    const navbarToggler = document.querySelector('.navbar-toggler')
    
    if (!navbarCollapse || !navbarToggler) return
    
    // Add close button
    this.addCloseButton(navbarCollapse)
    
    // Use MutationObserver to watch for class changes
    const observer = new MutationObserver((mutations) => {
      mutations.forEach((mutation) => {
        if (mutation.type === 'attributes' && mutation.attributeName === 'class') {
          const isOpen = navbarCollapse.classList.contains('show')
          console.log('Menu state changed:', isOpen)
          if (isOpen) {
            this.lockBodyScroll()
          } else {
            this.unlockBodyScroll()
          }
        }
      })
    })
    
    // Start observing
    observer.observe(navbarCollapse, {
      attributes: true,
      attributeFilter: ['class']
    })
    
    // Handle menu item clicks to close menu
    const menuItems = navbarCollapse.querySelectorAll('.nav-link:not(.dropdown-toggle), .dropdown-item')
    menuItems.forEach(item => {
      item.addEventListener('click', () => {
        this.closeMobileMenu()
      })
    })
    
    // Handle clicks outside menu
    document.addEventListener('click', (e) => {
      if (navbarCollapse.classList.contains('show') && 
          !navbarCollapse.contains(e.target) && 
          !navbarToggler.contains(e.target)) {
        this.closeMobileMenu()
      }
    })
    
    // Handle escape key
    document.addEventListener('keydown', (e) => {
      if (e.key === 'Escape' && navbarCollapse.classList.contains('show')) {
        this.closeMobileMenu()
      }
    })
  }
  
  addCloseButton(navbarCollapse) {
    // Remove existing close button if any
    const existingCloseBtn = navbarCollapse.querySelector('.mobile-menu-close')
    if (existingCloseBtn) {
      existingCloseBtn.remove()
    }
    
    // Create close button with Bootstrap classes
    const closeButton = document.createElement('button')
    closeButton.className = 'mobile-menu-close btn btn-link position-absolute top-0 end-0 m-3 p-2 d-lg-none'
    closeButton.setAttribute('aria-label', 'Закрыть меню')
    closeButton.setAttribute('type', 'button')
    
    // Bootstrap Icons close icon
    closeButton.innerHTML = '<i class="bi bi-x-lg"></i>'
    
    // Add click handler
    closeButton.addEventListener('click', () => {
      this.closeMobileMenu()
    })
    
    navbarCollapse.appendChild(closeButton)
  }
  
  closeMobileMenu() {
    const navbarCollapse = document.querySelector('#navbarNav')
    const navbarToggler = document.querySelector('.navbar-toggler')
    
    if (navbarCollapse && navbarCollapse.classList.contains('show')) {
      navbarCollapse.classList.remove('show')
      navbarToggler.setAttribute('aria-expanded', 'false')
      
      // Remove Bootstrap's body class if present
      document.body.classList.remove('modal-open')
      
      // Unlock body scroll
      this.unlockBodyScroll()
    }
  }
  
  lockBodyScroll() {
    // Prevent body scroll when mobile menu is open
    console.log('Locking body scroll')
    document.body.classList.add('mobile-menu-open')
  }
  
  unlockBodyScroll() {
    // Restore body scroll when mobile menu is closed
    console.log('Unlocking body scroll')
    document.body.classList.remove('mobile-menu-open')
  }
}
