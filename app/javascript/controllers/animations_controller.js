import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    this.initParticles()
    this.initSpotlight()
    this.initScrollReveal()
    this.initTilt()
    this.initRipple()
    this.initProgressBar()
    this.initHeaderScroll()
  }

  disconnect() {
    if (this._spotlightHandler) window.removeEventListener('mousemove', this._spotlightHandler)
    if (this._scrollHandler)   window.removeEventListener('scroll', this._scrollHandler)
    if (this._animFrame)       cancelAnimationFrame(this._animFrame)
  }

  initProgressBar() {
    const bar = document.getElementById('page-progress')
    if (!bar) return
    bar.style.width = '0%'
    bar.style.opacity = '1'
    let w = 0
    const tick = () => {
      if (w < 85) {
        w += Math.random() * 15
        if (w > 85) w = 85
        bar.style.width = w + '%'
        this._barTimer = setTimeout(tick, 250)
      }
    }
    tick()
    setTimeout(() => {
      clearTimeout(this._barTimer)
      bar.style.width = '100%'
      setTimeout(() => { bar.style.opacity = '0' }, 400)
    }, 900)
  }

  initHeaderScroll() {
    const header = document.querySelector('header')
    if (!header) return
    this._scrollHandler = () => {
      if (window.scrollY > 40) {
        header.style.backdropFilter = 'blur(32px)'
        header.style.borderBottomColor = 'rgba(30,41,59,0.8)'
      } else {
        header.style.backdropFilter = ''
        header.style.borderBottomColor = ''
      }
    }
    window.addEventListener('scroll', this._scrollHandler, { passive: true })
  }

  initSpotlight() {
    const spotlight = document.querySelector('.spotlight')
    if (!spotlight) return
    this._spotlightHandler = (e) => {
      spotlight.style.left = e.clientX + 'px'
      spotlight.style.top  = e.clientY + 'px'
    }
    window.addEventListener('mousemove', this._spotlightHandler, { passive: true })
  }

  initParticles() {
    const canvas = document.getElementById('particles-canvas')
    if (!canvas) return
    const ctx = canvas.getContext('2d')
    const resize = () => {
      canvas.width  = window.innerWidth
      canvas.height = window.innerHeight
    }
    resize()
    window.addEventListener('resize', resize, { passive: true })

    const COLORS = ['rgba(59,130,246,', 'rgba(6,182,212,', 'rgba(139,92,246,', 'rgba(16,185,129,']
    const count  = Math.min(55, Math.floor(window.innerWidth / 22))
    const particles = Array.from({ length: count }, () => ({
      x: Math.random() * canvas.width,
      y: Math.random() * canvas.height,
      r: Math.random() * 1.8 + 0.3,
      vx: (Math.random() - 0.5) * 0.3,
      vy: (Math.random() - 0.5) * 0.3,
      color: COLORS[Math.floor(Math.random() * COLORS.length)],
      alpha: Math.random() * 0.5 + 0.1,
      pulse: Math.random() * Math.PI * 2,
    }))

    const draw = () => {
      ctx.clearRect(0, 0, canvas.width, canvas.height)
      particles.forEach(p => {
        p.x += p.vx; p.y += p.vy; p.pulse += 0.02
        if (p.x < 0) p.x = canvas.width
        if (p.x > canvas.width) p.x = 0
        if (p.y < 0) p.y = canvas.height
        if (p.y > canvas.height) p.y = 0
        const a = p.alpha * (0.7 + 0.3 * Math.sin(p.pulse))
        ctx.beginPath()
        ctx.arc(p.x, p.y, p.r, 0, Math.PI * 2)
        ctx.fillStyle = p.color + a + ')'
        ctx.fill()
      })
      for (let i = 0; i < particles.length; i++) {
        for (let j = i + 1; j < particles.length; j++) {
          const dx = particles[i].x - particles[j].x
          const dy = particles[i].y - particles[j].y
          const dist = Math.sqrt(dx * dx + dy * dy)
          if (dist < 110) {
            ctx.beginPath()
            ctx.moveTo(particles[i].x, particles[i].y)
            ctx.lineTo(particles[j].x, particles[j].y)
            ctx.strokeStyle = `rgba(99,155,246,${(1 - dist / 110) * 0.12})`
            ctx.lineWidth = 0.6
            ctx.stroke()
          }
        }
      }
      this._animFrame = requestAnimationFrame(draw)
    }
    draw()
  }

  initScrollReveal() {
    const elements = document.querySelectorAll('.reveal, .reveal-left, .reveal-right')
    if (!elements.length) return
    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          const delay = parseInt(entry.target.dataset.delay || '0')
          setTimeout(() => entry.target.classList.add('visible'), delay)
          observer.unobserve(entry.target)
        }
      })
    }, { threshold: 0.12 })
    elements.forEach(el => observer.observe(el))
  }

  initTilt() {
    document.querySelectorAll('.tilt-card').forEach(card => {
      card.addEventListener('mousemove', (e) => {
        const rect = card.getBoundingClientRect()
        const x = e.clientX - rect.left, y = e.clientY - rect.top
        const cx = rect.width / 2, cy = rect.height / 2
        card.style.transform = `perspective(600px) rotateX(${((y-cy)/cy)*-12}deg) rotateY(${((x-cx)/cx)*12}deg) scale(1.04)`
      })
      card.addEventListener('mouseleave', () => {
        card.style.transform = 'perspective(600px) rotateX(0) rotateY(0) scale(1)'
      })
    })
  }

  initRipple() {
    document.querySelectorAll('.ripple-container').forEach(btn => {
      btn.addEventListener('click', (e) => {
        const rect = btn.getBoundingClientRect()
        const size = Math.max(rect.width, rect.height)
        const ripple = document.createElement('span')
        ripple.classList.add('ripple')
        ripple.style.cssText = `width:${size}px;height:${size}px;left:${e.clientX - rect.left - size/2}px;top:${e.clientY - rect.top - size/2}px`
        btn.appendChild(ripple)
        setTimeout(() => ripple.remove(), 700)
      })
    })
  }
}
