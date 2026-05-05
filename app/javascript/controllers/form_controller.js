import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["password", "confirmation", "strengthBar", "strengthLabel", "submit", "checkLength", "checkMatch"]

  connect() {
    this.initInputEffects()
    this.initFormSubmit()
    if (this.hasPasswordTarget) this.initPasswordStrength()
  }

  // ─── Input focus/blur glow effects ─────────────────────────────────────────
  initInputEffects() {
    this.element.querySelectorAll('input').forEach(input => {
      input.classList.add('input-premium')
      input.addEventListener('focus', () => {
        input.parentElement.querySelector('label')?.classList.add('text-blue-400')
      })
      input.addEventListener('blur', () => {
        input.parentElement.querySelector('label')?.classList.remove('text-blue-400')
        if (input.required && input.value && !input.validity.valid) {
          input.classList.add('error')
          setTimeout(() => input.classList.remove('error'), 600)
        }
      })
    })
  }

  // ─── Loading spinner on submit ─────────────────────────────────────────────
  initFormSubmit() {
    const form = this.element.querySelector('form') || this.element
    if (!form) return
    form.addEventListener('submit', () => {
      const btn = form.querySelector('[type="submit"]')
      if (!btn) return
      const original = btn.value || btn.textContent
      btn.disabled = true
      btn.innerHTML = '<span class="spinner"></span><span style="margin-left:8px">Procesando...</span>'
      btn.style.display = 'inline-flex'
      btn.style.alignItems = 'center'
      btn.style.justifyContent = 'center'
      btn.style.gap = '8px'
      // Re-enable after 5s as fallback
      setTimeout(() => {
        btn.disabled = false
        btn.textContent = original
      }, 5000)
    })
  }

  // ─── Password strength meter ────────────────────────────────────────────────
  initPasswordStrength() {
    this.passwordTarget.addEventListener('input', () => this.checkStrength())
    if (this.hasConfirmationTarget) {
      this.confirmationTarget.addEventListener('input', () => this.checkPasswordMatch())
    }
  }

  checkStrength() {
    const val = this.passwordTarget.value
    let score = 0
    if (val.length >= 8) score++
    if (val.length >= 12) score++
    if (/[A-Z]/.test(val)) score++
    if (/[0-9]/.test(val)) score++
    if (/[^A-Za-z0-9]/.test(val)) score++

    const labels  = ['', 'Muy débil', 'Débil', 'Regular', 'Fuerte', 'Muy fuerte']
    const colors  = ['', '#ef4444', '#f97316', '#eab308', '#22c55e', '#10b981']
    const widths  = ['0%', '20%', '40%', '60%', '80%', '100%']

    if (this.hasStrengthBarTarget) {
      this.strengthBarTarget.style.width = widths[score]
      this.strengthBarTarget.style.background = colors[score]
    }
    if (this.hasStrengthLabelTarget) {
      this.strengthLabelTarget.textContent = labels[score]
      this.strengthLabelTarget.style.color  = colors[score]
    }

    // Live check indicators
    if (this.hasCheckLengthTarget) {
      const ok = val.length >= 8
      this.checkLengthTarget.textContent = ok ? '✓ Mínimo 8 caracteres' : '✗ Mínimo 8 caracteres'
      this.checkLengthTarget.style.color  = ok ? '#22c55e' : '#94a3b8'
    }
    this.checkPasswordMatch()
  }

  checkPasswordMatch() {
    if (!this.hasConfirmationTarget || !this.hasCheckMatchTarget) return
    const match = this.passwordTarget.value === this.confirmationTarget.value && this.confirmationTarget.value.length > 0
    this.checkMatchTarget.textContent = match ? '✓ Las contraseñas coinciden' : '✗ Las contraseñas no coinciden'
    this.checkMatchTarget.style.color  = match ? '#22c55e' : '#94a3b8'
  }
}
