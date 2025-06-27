<template>
  <div id="body">
    <header>
            <div class="navbar-left">
                <h1><a href="#" class="brand-name">Prime<span>Fit</span></a></h1>

                <nav :class="{ open: isMenuOpen }">
                    <router-link to="/">Home</router-link>
                    <router-link to="/shop">Shop</router-link>
                    <router-link to="/plans">Subscriptions</router-link>
                    <router-link to="/login" class="mobile-login">Login</router-link>
                </nav>
            </div>

            <div class="navbar-right">
                <button class="login-btn" @click="Login">Log In</button>
                <div class="burger" @click="toggleMenu">
                    <span></span>
                    <span></span>
                    <span></span>
                </div>
            </div>
        </header>

    <section class="hero-section">
      <div class="hero-text">
        <h1>Choose Your Perfect Subscription Plan</h1>
        <p>
          Get access to premium gym equipment for your home or business with
          flexible rental options.
        </p>
      </div>
    </section>

    <div class="container">
      <div class="duration-switch">
        <button 
          v-for="duration in durations" 
          :key="duration.id" 
          :class="{ active: activeDuration === duration.id }"
          @click="setActiveDuration(duration.id)"
          class="duration-btn"
        >
          {{ duration.label }}
        </button>
      </div>
      
      <div v-if="isLoading" class="loading-message">
        <p>Loading subscription plans...</p>
        <div class="loading-animation"></div>
      </div>
      
      <div v-else-if="error" class="error-message">
        <p>{{ error }}</p>
      </div>

      <div v-else-if="filteredPlans.length" class="plans">
        <div 
          class="plan" 
          v-for="plan in filteredPlans" 
          :key="plan.plan_id"
          :class="{ active: selectedPlan === plan }"
        >
          <h2>{{ plan.name }}</h2>
          <p class="price">R{{ plan.price }} <span class="per-month">(p/m)</span></p>
          <ul>
            <li v-for="(feature, idx) in (plan.features ? plan.features.split(', ') : [])" :key="idx">
              <span class="feature-icon">✓</span>{{ feature }}
            </li>
          </ul>
          <button 
            class="select-plan"
            @click="selectedPlan && selectedPlan.name === plan.name ? continueToCart() : selectPlan(plan)"
          >
            {{ selectedPlan && selectedPlan.name === plan.name ? 'Continue' : 'Select Plan' }}
          </button>
        </div>
      </div>
      
      <div v-else class="no-plans-message">
        <p>No subscription plans available for this duration.</p>
      </div>
    </div>

    <section class="benefits-section">
      <h1>Why Choose PrimeFit</h1>
      <div class="benefits-grid">
        <div v-for="(reason, index) in reasons" :key="index" class="benefit-card">
          <div class="benefit-icon">
            <i :class="['fas', reason.icon]"></i>
          </div>
          <h2>{{ reason.title }}</h2>
          <p class="benefit-text">{{ reason.description }}</p>
        </div>
      </div>
    </section>

    <footer class="footer">
      <div class="footer-content">
        <div class="footer-section about">
          <h3><a href="#" class="brand-name">Prime<span>Fit</span></a></h3>
          <p>Your complete fitness solution for equipment, apparel, rentals, and training.</p>
        </div>
        <div class="footer-section links">
          <h3>Quick Links</h3>
          <ul>
            <li><a href="#">About Us</a></li>
            <li><a href="#">Contact</a></li>
            <li><a href="#">FAQ</a></li>
            <li><a href="#">Terms & Conditions</a></li>
            <li><a href="#">Privacy Policy</a></li>
          </ul>
        </div>
        <div class="footer-section social">
          <h3>Connect</h3>
          <ul class="social-links">
            <li><a href="#"><i class="fab fa-instagram"></i> Instagram</a></li>
            <li><a href="#"><i class="fab fa-facebook"></i> Facebook</a></li>
            <li><a href="#"><i class="fab fa-youtube"></i> YouTube</a></li>
            <li><a href="#"><i class="fab fa-twitter"></i> Twitter</a></li>
          </ul>
        </div>
      </div>
      <div class="footer-divider"></div>
      <div class="footer-bottom">
        <p>&copy; 2025 PrimeFit. All rights reserved.</p>
      </div>
    </footer>
  </div>
</template>

<script>
import { mapState, mapActions } from 'vuex';

export default {
  name: "PlansView",
  data() {
    return {
      isMenuOpen: false,
      activeDuration: '12',
      selectedPlan: null,
      durations: [
        { id: '12 months', label: '12 Months' },
        { id: '24 months', label: '24 Months' },
        { id: '36 months', label: '36 Months' }
      ],
      activeDuration: '12 months',
      reasons: [
        { icon: 'fa-truck', title: 'Free Delivery', description: 'We deliver and install all equipment' },
        { icon: 'fa-wrench', title: 'Maintenance', description: 'Keep the equipment in perfect condition' },
        { icon: 'fa-sync-alt', title: 'Flexible', description: 'Exchange equipment whenever you want' },
        { icon: 'fa-headset', title: 'Expert Support', description: 'Get help from our fitness specialists' },
      ],
      isLoading: false,
      error: null
    };
  },
  computed: {
    ...mapState({
      allPlans: state => state.plans
    }),
    filteredPlans() {
      if (!this.allPlans || !Array.isArray(this.allPlans)) return [];

  const duration = parseInt(this.activeDuration);
  console.log("Filtering for duration:", duration);

  const filtered = this.allPlans.filter(plan => {
    const planDuration = parseInt(plan.duration_months.replace(' months', ''));
    console.log(`Plan ${plan.name} duration:`, planDuration);
    return planDuration === duration;
  });

  console.log("Filtered plans:", filtered);

  return filtered;
    }
  },
  methods: {
    ...mapActions(['AllPlans']),
    setActiveDuration(durationId) {
      this.activeDuration = durationId;
    },
    selectPlan(plan) {
      this.selectedPlan = plan;
    },
    continueToCart() {
      if (this.selectedPlan) {
        const subtotal = parseFloat(this.selectedPlan.price);
        const tax = subtotal * 0.15;
        const delivery = 50.00;
        const total = subtotal + tax + delivery;

        this.$router.push({
          path: "/payment",
          query: {
            name: this.selectedPlan.name,
            duration: this.selectedPlan.duration_months,
            price: subtotal.toFixed(2),
            subtotal: subtotal.toFixed(2),
            tax: tax.toFixed(2),
            delivery: delivery.toFixed(2),
            total: total.toFixed(2),
            totalQuantity: 1,
          },
        });
      } else {
        alert("Please select a plan");
      }
    },
    Login() {
            this.$router.push("/login");
        },
        toggleMenu() {
            this.isMenuOpen = !this.isMenuOpen;
        }
  },
  async mounted() {
    this.isLoading = true;
    this.error = null;
    try {
      await this.AllPlans();
    } catch (err) {
      this.error = "Failed to load subscription plans.";
      console.error("Subscription load error:", err);
    } finally {
      this.isLoading = false;
    }
  }
};
</script>

<style scoped>
#body {
  font-family: 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  background-color: #333;
  margin: 0;
  padding: 0;
  color: white;
  line-height: 1.6;
}


header {
  background-color: #222;
  padding: 30px 5%;
  display: flex;
  justify-content: space-between;
  align-items: center;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
  position: sticky;
  top: 0;
  z-index: 1000;
}

.brand-name {
  color: white;
  font-size: 2.2rem;
  font-weight: 700;
  text-decoration: none;
  font-family: 'Montserrat', sans-serif;
  letter-spacing: 1px;
  transition: all 0.3s ease;
}

.brand-name:hover {
  transform: scale(1.02);
}

.brand-name span {
  color: #ff4757;
  font-weight: 800;
}

.navbar-left {
  display: flex;
  align-items: center;
  gap: 2rem;
}

nav {
  display: flex;
  gap: 0.5rem;
}

nav a {
  padding: 0.8rem 1.5rem;
  text-decoration: none;
  color: white;
  font-weight: 600;
  font-size: 1rem;
  border-radius: 6px;
  transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
  position: relative;
  overflow: hidden;
}

nav a:hover {
  background-color: rgba(255, 71, 87, 0.1);
  color: #ff4757;
}

nav a::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  width: 0;
  height: 3px;
  background-color: #ff4757;
  transition: width 0.3s ease;
}

nav a:hover::after {
  width: 100%;
}

.hero-section {
  background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), 
              url('https://images.unsplash.com/photo-1571902943202-507ec2618e8f?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80') no-repeat center center/cover;
  padding: 5rem 1rem;
  text-align: center;
}

.hero-text h1 {
  font-size: 3rem;
  font-weight: 800;
  margin-bottom: 1.5rem;
  letter-spacing: 0.5px;
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
}

.hero-text p {
  font-size: 1.4rem;
  max-width: 700px;
  margin: 0 auto;
  opacity: 0.9;
}

.container {
  max-width: 1200px;
  margin: 3rem auto;
  padding: 2rem;
  background-color: #444;
  border-radius: 12px;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
}

.duration-switch {
  display: flex;
  justify-content: center;
  gap: 1rem;
  margin: 2rem 0;
}

.duration-btn {
  padding: 0.8rem 1.5rem;
  border: none;
  border-radius: 6px;
  background-color: white;
  color: crimson;
  font-weight: 700;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.duration-btn:hover {
  transform: translateY(-3px);
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.duration-btn.active {
  background-color: crimson;
  color: white;
  transform: translateY(-3px);
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
}

.plans {
  display: flex;
  justify-content: center;
  flex-wrap: wrap;
  gap: 2rem;
  margin: 3rem 0;
}

.plan {
  background-color: white;
  border: 2px solid crimson;
  border-radius: 12px;
  padding: 2rem;
  width: 100%;
  max-width: 350px;
  display: flex;
  flex-direction: column;
  position: relative;
  min-height: 500px;
  transition: all 0.3s ease;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

.plan:hover {
  transform: translateY(-10px);
  box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
}

.plan.active {
  background-color: #333;
  color: white;
  transform: translateY(-10px) scale(1.03);
  box-shadow: 0 15px 30px rgba(220, 20, 60, 0.3);
}

.plan h2 {
  font-size: 1.8rem;
  color: crimson;
  margin-bottom: 1rem;
}

.plan.active h2 {
  color: white;
}

.price {
  font-size: 2rem;
  font-weight: 700;
  color: crimson;
  margin-bottom: 1.5rem;
}

.per-month {
  font-size: 1rem;
  font-weight: normal;
  opacity: 0.8;
}

.plan.active .price {
  color: white;
}

.plan ul {
  list-style: none;
  padding: 0;
  margin: 1.5rem 0;
  text-align: left;
  flex-grow: 1;
}

.plan li {
  padding: 0.8rem 0;
  margin-bottom: 0.5rem;
  border-bottom: 1px solid #eee;
  display: flex;
  align-items: center;
  color: #333;
}

.plan.active li {
  color: white;
  border-bottom-color: rgba(255, 255, 255, 0.2);
}

.feature-icon {
  display: inline-block;
  width: 24px;
  height: 24px;
  background-color: crimson;
  color: white;
  border-radius: 50%;
  text-align: center;
  line-height: 24px;
  margin-right: 0.8rem;
  font-size: 0.8rem;
}

.plan.active .feature-icon {
  background-color: white;
  color: crimson;
}

.select-plan {
  background-color: #333;
  color: white;
  padding: 1rem;
  border: none;
  border-radius: 6px;
  font-weight: 700;
  cursor: pointer;
  transition: all 0.3s ease;
  margin-top: auto;
  width: 100%;
}

.select-plan:hover {
  background-color: crimson;
  transform: translateY(-3px);
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.plan.active .select-plan {
  background-color: crimson;
  color: white;
  border: 2px solid white;
}

.loading-message {
  padding: 2rem;
  text-align: center;
}

.loading-animation {
  border: 5px solid #f3f3f3;
  border-top: 5px solid crimson;
  border-radius: 50%;
  width: 40px;
  height: 40px;
  animation: spin 1s linear infinite;
  margin: 1rem auto;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

.error-message {
  color: #ff6b6b;
  padding: 2rem;
  text-align: center;
  font-weight: 600;
}

.no-plans-message {
  padding: 2rem;
  text-align: center;
  color: #aaa;
}

.benefits-section {
  max-width: 1200px;
  margin: 4rem auto;
  padding: 0 2rem;
}

.benefits-section h1 {
  font-size: 2.5rem;
  margin-bottom: 3rem;
  text-align: center;
  position: relative;
  padding-bottom: 1rem;
}

.benefits-section h1::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 50%;
  transform: translateX(-50%);
  width: 100px;
  height: 3px;
  background-color: crimson;
}

.benefits-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 2rem;
}

.benefit-card {
  background-color: white;
  border-radius: 10px;
  padding: 2rem;
  text-align: center;
  transition: all 0.3s ease;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

.benefit-card:hover {
  transform: translateY(-10px);
  box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
}

.benefit-icon {
  font-size: 2.5rem;
  color: crimson;
  margin-bottom: 1.5rem;
}

.benefit-card h2 {
  font-size: 1.5rem;
  color: #333;
  margin-bottom: 1rem;
}

.benefit-text {
  color: #666;
  font-size: 1rem;
  line-height: 1.6;
}
.footer {
  background-color: #222;
  color: #f1f1f1;
  padding: 3rem 5% 2rem;
  margin-top: 3rem;
}

.footer-content {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 3rem;
  max-width: 1200px;
  margin: 0 auto;
}

.footer-section h3 {
  font-size: 1.5rem;
  margin-bottom: 1.5rem;
  color: white;
  position: relative;
  padding-bottom: 0.5rem;
}

.footer-section h3::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  width: 50px;
  height: 3px;
  background-color: #ff4757;
}

.footer-section p {
  color: #bbb;
  line-height: 1.6;
  margin-bottom: 1.5rem;
}

.footer-section ul {
  list-style: none;
  padding: 0;
}

.footer-section ul li {
  margin-bottom: 0.8rem;
}

.footer-section ul li a {
  color: #ddd;
  text-decoration: none;
  transition: all 0.3s ease;
  display: inline-block;
}

.footer-section ul li a:hover {
  color: #ff4757;
  transform: translateX(5px);
}

.social-links li a {
  display: flex;
  align-items: center;
  gap: 0.8rem;
}

.social-links li i {
  color: #ff4757;
  font-size: 1.2rem;
}

.footer hr {
  border: none;
  height: 1px;
  background-color: #444;
  margin: 2rem auto;
  max-width: 1200px;
}

.footer-bottom {
  text-align: center;
  color: #888;
  font-size: 0.9rem;
}

/* Burger menu styles */
.burger {
    display: none;
    cursor: pointer;
    padding: 10px;
    z-index: 100;
}

.burger span {
    display: block;
    width: 30px;
    height: 3px;
    background-color: white;
    margin: 5px 0;
    transition: all 0.3s ease;
}

@media (min-width: 1024px) {
    .mobile-login {
        display: none !important;
    }

    .desktop-login {
        display: inline-block;
    }
}

@media (max-width: 768px) {
  
  .burger {
        display: block;
    }

    nav {
        position: fixed;
        top: 0;
        left: -100%;
        width: 60%;
        height: 100vh;
        background-color: #222;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        transition: all 0.5s ease;
        z-index: 99;
    }

    nav.open {
        left: 0;
    }

    nav a {
        margin: 15px 0;
        font-size: 1.2rem;
    }

    .login-btn {
        display: none;
    }

    .mobile-login {
        display: block;
    }
  
  .hero-text h1 {
    font-size: 2.2rem;
  }
  
  .hero-text p {
    font-size: 1.1rem;
  }
  
  .duration-switch {
    flex-wrap: wrap;
  }
  
  .plans {
    flex-direction: column;
    align-items: center;
  }
  
  .plan {
    width: 100%;
    max-width: none;
  }
}
</style>