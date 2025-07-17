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

    <div class="container">
      <section class="hero">
        <h1>Premium Gym Apparel</h1>
        <p>Elevate your workout with our high-performance collection</p>
        <button class="shop-now" @click="Products">Shop Now</button>
      </section>

      <section class="collections">
        <div class="collection-item collection-1">
          <button @click="goToGymAttire">Apparels</button>
        </div>

        <div class="collection-item collection-2">
          <button @click="goToGymEquipment">Equipment</button>
        </div>
        <div class="collection-item collection-3">
          <button @click="goToFitnessTrackers">Accessories</button>
        </div>
      </section>

      <h2>Featured Products</h2>
      <section class="featured-products">
        <div class="product-item" v-for="product in products" :key="product.id">
          <img :src="product.image" :alt="product.name" />
          <h3 class="product_name">{{ product.name }}</h3>
        </div>
      </section>
    </div>


    <footer class="footer">
      <div class="footer-content">
        <div class="footer-section">
          <h3><a href="#"class="brand-name">Prime<span>Fit</span></a></h3>
          <p>Your complete fitness solution for equipment, apparel, rentals, and training.</p>
        </div>
        <div class="footer-section">
          <h3>Quick Links</h3>
          <ul>
            <li><a href="#">About Us</a></li>
            <li><a href="#">Contact</a></li>
            <li><a href="#">FAQ</a></li>
            <li><a href="#">Terms & Conditions</a></li>
            <li><a href="#">Privacy Policy</a></li>
          </ul>
        </div>
        <div class="footer-section">
          <h3>Connect</h3>
          <ul class="social-links">
            <li><a href="#"><i class="fab fa-instagram"></i> Instagram</a></li>
            <li><a href="#"><i class="fab fa-facebook"></i>Facebook</a></li>
            <li><a href="#"><i class="fab fa-youtube"></i> YouTube</a></li>
            <li><a href="#"><i class="fab fa-twitter"></i> Twitter</a></li>
          </ul>
        </div>
      </div>
      <hr />
      <div class="footer-bottom">
        <p>© 2025 PrimeFit. All rights reserved.</p>
      </div>
    </footer>
  </div>
</template>


<script>
export default {
  name: "ShopView",
  data() {
    return {
      isMenuOpen: false,
      products: [
        {
          id: 1,
          name: "Performance T-Shirt",
          image: "https://github.com/TwinnJoe/PrimeFit/blob/main/src/assets/images/Featured/perfomance%20T-shirt.jpeg?raw=true"
        },
        {
          id: 2,
          name: "Training Shorts",
          image: "https://github.com/TwinnJoe/PrimeFit/blob/main/src/assets/images/Featured/training%20shorts.jpeg?raw=true"
        },
        {
          id: 3,
          name: "Compression Leggings",
          image: "https://github.com/TwinnJoe/PrimeFit/blob/main/src/assets/images/Featured/compression-leggings.jpeg?raw=true"
        },
        {
          id: 4,
          name: "Own the Run Leggings",
          image: "https://github.com/TwinnJoe/PrimeFit/blob/main/src/assets/images/Featured/men-leggings.jpeg?raw=true"
        }
      ]
    };
  },
  methods: {
    Products() {
      this.$router.push("/products");
    },
    goToGymAttire() {
      this.$router.push({ path: '/products', query: { category: 'Gym Attire' } });
    },
    goToGymEquipment() {
      this.$router.push({ path: '/products', query: { category: 'Gym Equipment' } });
    },
    goToFitnessTrackers() {
      this.$router.push({ path: '/products', query: { category: 'Fitness Trackers' } });
    },
    Login() {
            this.$router.push("/login");
        },
        toggleMenu() {
            this.isMenuOpen = !this.isMenuOpen;
        }
  }
};
</script>

<style scoped>

#body {
  font-family: 'Poppins', 'Segoe UI', Roboto, sans-serif;
  background-color: #1a1a1a;
  margin: 0;
  padding: 0;
  color: #ffffff;
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

.navbar-right {
    display: flex;
    align-items: center;
    gap: 1rem;
}
.container {
  max-width: 1400px;
  margin: 2rem auto;
  padding: 0 2rem;
}

.hero {
  padding: 4rem;
  background-image: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.7)), url("../assets/images/Displays/apparel-hero.jpg");
  color: white;
  border-radius: 16px;
  height: 600px;
  background-size: cover;
  background-position: center;
  display: flex;
  border: 2px solid #e63946;
  flex-direction: column;
  justify-content: center;
  align-items: flex-start;
  text-align: left;
  margin-bottom: 3rem;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.3);
}

.hero h1 {
  font-size: 3.5rem;
  font-weight: 800;
  margin: 0 0 1rem 0;
  line-height: 1.1;
  max-width: 700px;
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
}

.hero p {
  font-size: 1.5rem;
  font-weight: 400;
  max-width: 600px;
  margin-bottom: 2rem;
  color: rgba(255, 255, 255, 0.9);
  text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
}

.shop-now {
  padding: 1rem 2rem;
  font-size: 1.1rem;
  background-color: #e63946;
  color: white;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.3s ease;
  font-weight: 600;
  letter-spacing: 0.5px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.shop-now:hover {
  background-color: #c1121f;
  transform: translateY(-3px);
  box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
}

.shop-now:active {
  transform: translateY(0);
}

button {
  background-color: #e63946;
  color: white;
  padding: 1rem 2rem;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  font-weight: 600;
  font-size: 1.1rem;
  transition: all 0.3s ease;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

button:hover {
  background-color: #c1121f;
  transform: translateY(-3px);
  box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
}

  .login-btn {
    color: white;
    padding: 10px 20px;
    border-radius: 8px;
    font-weight: 600;
    font-size: 1rem;
    border: 2px solid crimson;
    background: transparent;
    cursor: pointer;
    transition: all 0.3s ease;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.login-btn:hover {
    background-color: crimson;
    transform: translateY(-3px);
    box-shadow: 0 5px 15px rgba(220, 20, 60, 0.3);
}

.login-btn:active {
    transform: translateY(-1px);
}

.collections {
  display: flex;
  justify-content: space-between;
  gap: 2rem;
  margin-bottom: 3rem;
  flex-wrap: wrap;
}

.collection-item {
  flex: 1;
  min-width: 300px;
  height: 400px;
  border-radius: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  background-size: cover;
  background-position: center;
  position: relative;
  overflow: hidden;
  border: 2px solid #e63946;
  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
  transition: all 0.3s ease;
}

.collection-item::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.4);
}

.collection-item:hover {
  transform: translateY(-5px);
  box-shadow: 0 12px 24px rgba(0, 0, 0, 0.3);
}

.collection-item button {
  position: relative;
  z-index: 1;
  text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.8);
}

.collection-1 {
  background-image: url('../assets/images/Categories/men collection.jpeg');
}

.collection-2 {
  background-image: url('../assets/images/Categories/equipment_collection.jpg');
}

.collection-3 {
  background-image: url('../assets/images/Categories/Accessories-category.jpg');
}

h2 {
  text-align: center;
  color: white;
  font-size: 2.5rem;
  margin: 3rem 0;
  font-weight: 700;
  position: relative;
}

h2::after {
  content: '';
  display: block;
  width: 100px;
  height: 4px;
  background: #e63946;
  margin: 1rem auto;
  border-radius: 2px;
}

.featured-products {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 2rem;
  margin: 3rem 0;
}

.product-item {
  background-color: #2a2a2a;
  padding: 1.5rem;
  border-radius: 16px;
  border: 2px solid #e63946;
  text-align: center;
  transition: all 0.3s ease;
  overflow: hidden;
}

.product-item:hover {
  transform: translateY(-5px);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.3);
}

.product-item img {
  width: 100%;
  height: 300px;
  object-fit: cover;
  border-radius: 12px;
  margin-bottom: 1.5rem;
  transition: transform 0.3s ease;
}

.product-item:hover img {
  transform: scale(1.03);
}

.product_name {
  font-size: 1.3rem;
  font-weight: 600;
  margin: 1rem 0 0;
  color: #ffffff;
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
/* Responsive adjustments */

  @media (min-width: 1024px) {
    .mobile-login {
        display: none !important;
    }

    .desktop-login {
        display: inline-block;
    }
}
@media (max-width: 1024px) {
  .hero {
    height: 500px;
    padding: 3rem;
  }
  
  .hero h1 {
    font-size: 3rem;
  }
  
  .collection-item {
    height: 350px;
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

  .hero {
    height: 400px;
    padding: 2rem;
    align-items: center;
    text-align: center;
  }
  
  .hero h1 {
    font-size: 2.5rem;
  }
  
  .hero p {
    font-size: 1.2rem;
  }
  
  .collections {
    flex-direction: column;
    height: 800px;
  }
  
  .collection-item {
    min-width: 100%;
  }
}

@media (max-width: 480px) {
  .hero {
    height: 350px;
    padding: 1.5rem;
  }
  
  .hero h1 {
    font-size: 2rem;
  }
  
  .hero p {
    font-size: 1rem;
  }

  .featured-products  {
    grid-template-columns: 1fr;
  }

  .product-item {
    text-align: center;
  }

  .product_name {
  padding-bottom: 20px;
  font-size: 1.2rem;
}
  .shop-now, button {
    padding: 0.75rem 1.5rem;
    font-size: 1rem;
  }
  
  h2 {
    font-size: 2rem;
  }
  
  .footer-content {
    grid-template-columns: 1fr;
  }
}

/* Burger animation */
.burger.open span:nth-child(1) {
    transform: rotate(45deg) translate(5px, 6px);
}

.burger.open span:nth-child(2) {
    opacity: 0;
}

.burger.open span:nth-child(3) {
    transform: rotate(-45deg) translate(5px, -6px);
}

/* Loading animation */
@keyframes spin {
    0% {
        transform: rotate(0deg);
    }

    100% {
        transform: rotate(360deg);
    }
}
</style>
