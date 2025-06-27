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
        <router-link to="/cart">
          <button class="cart-icon">
            <i class="fa fa-shopping-cart"></i>
          </button>
        </router-link>
        <div class="burger" @click="toggleMenu">
          <span></span>
          <span></span>
          <span></span>
        </div>
      </div>
    </header>

    <div class="container">
      <h1>Fitness Equipment</h1>
      <div class="top-nav">
        <div class="tabs">
          <button v-for="tab in tabs" :key="tab" @click="updateProductDisplay(tab)"
            :class="{ active: activeTab === tab }">
            {{ tab }}
          </button>
        </div>
        <div class="filters">
          <select id="sortSelect" v-model="sortOption">
            <option value="all">All Prices</option>
            <option value="priceLow">Sort by: Price Low to High</option>
            <option value="priceHigh">Sort by: Price High to Low</option>
          </select>
        </div>
      </div>
      <div class="products">
        <div class="product-card" v-for="product in filteredProducts" :key="product.name">
          <div class="product-image">
            <img v-bind:src="product.image_url.images[0]" :alt="product.name" />
          </div>
          <h2>{{ product.name }}</h2>
          <span>R{{ (product.price * 1000).toLocaleString("en-ZA", {
            minimumFractionDigits: 2, maximumFractionDigits: 2
          }) }}</span>
          <a href="#" class="view-product" @click.prevent="showProductDetails(product)">View Product</a>
          <button @click="addToCart(product.name)">Add to Cart</button>
        </div>
      </div>
    </div>

    <footer class="footer">
      <div class="footer-content">
        <div class="footer-section">
          <h3><a href="#" class="brand-name">Prime<span>Fit</span></a></h3>
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
    <div v-if="showModal" class="modal">
      <div class="modal-content">
        <span class="close" @click="closeModal">&times;</span>
        <div class="modal-left">
          <h2>{{ selectedProduct.name }}</h2>
          <div class="product-info" v-if="selectedProduct && selectedProduct">
            <p>{{ formattedDetails.paragraph }}</p>
            <table v-if="formattedDetails.details.length">
              <thead>
                <tr>
                  <th colspan="2">Additional Information</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="(item, index) in formattedDetails.details" :key="index">
                  <td><strong>{{ item.label }}:</strong></td>
                  <td>{{ item.value }}</td>
                </tr>
              </tbody>
            </table>
          </div>
          <span>R{{ selectedProduct.price }}</span>
          <button @click="addToCart(selectedProduct.name)">Add to Cart</button>
        </div>
        <div class="modal-right">
          <div v-for="(image, index) in selectedProduct.image_url.images.slice(1)" :key="index">
            <img :src="image" :alt="selectedProduct.name + ' image ' + (index + 2)" />
          </div>
        </div>
      </div>
    </div>
    <div v-if="toastMessage" class="toast">{{ toastMessage }}</div>
  </div>
</template>
<script>

import { mapState, mapActions } from 'vuex';

export default {
  name: "ProductsView",
  data() {
    return {
      tabs: ["All Products", "Gym Equipment", "Gym Attire", "Fitness Trackers"],
      activeTab: "All Products",
      sortOption: "all",
      selectedProduct: null,
      toastMessage: "",
      showModal: false,
      isMenuOpen: false
    };
  },

  computed: {
    ...mapState({
      store: state => state.store
    }),

    filteredProducts() {
      if (!this.store) return []; // Prevent errors if data is not yet available

      let filtered = this.activeTab === "All Products"
        ? this.store
        : this.store.filter(store =>
          store.categories.toLowerCase() === this.activeTab.toLowerCase()
        );

      console.log("Filtered Products:", filtered);

      switch (this.sortOption) {
        case "priceLow":
          return filtered.slice().sort((a, b) => a.price - b.price);
        case "priceHigh":
          return filtered.slice().sort((a, b) => b.price - a.price);
        default:
          return filtered;
      }
    },

    formattedDetails() {
      if (!this.selectedProduct || !this.selectedProduct.description) {
        return { paragraph: "", details: [] };
      }

      const detailsArray = this.selectedProduct.description.split(". ");
      const paragraph = detailsArray.shift();
      const details = detailsArray
        .map(detail => {
          const [label, value] = detail.split(":").map(item => item.trim());
          return label && value ? { label, value } : null;
        })
        .filter(item => item);

      return { paragraph, details };
    }
  },

  methods: {
    // Map Vuex actions to methods
    ...mapActions(['AllProducts']),

    updateProductDisplay(tab) {
      this.activeTab = tab;
    },

    addToCart(productName) {
      let cart = JSON.parse(localStorage.getItem("cart")) || [];
      const product = this.store.find(item => item.name === productName);
      if (product) {
        let existingProduct = cart.find(item => item.name === product.name);
        if (existingProduct) {
          existingProduct.quantity += 1;
        } else {
          cart.push({ ...product, quantity: 1 });
        }
        localStorage.setItem("cart", JSON.stringify(cart));
        this.showToast(`${product.name} added to cart!`);
        setTimeout(() => {
          this.$router.push("/cart");
        }, 2000);
      }
    },

    showProductDetails(product) {
      this.selectedProduct = product;
      this.showModal = true;
    },

    closeModal() {
      this.showModal = false;
      this.selectedProduct = null;
    },

    showToast(message) {
      this.toastMessage = message;
      setTimeout(() => (this.toastMessage = ""), 3000);
    },
    Login() {
      this.$router.push("/login");
    },
    toggleMenu() {
      this.isMenuOpen = !this.isMenuOpen;
    }
  },

  // Fetch product data from Vuex store when the component is created
  created() {
    this.AllProducts();

    const categoryFromRoute = this.$route.query.category;
    if (categoryFromRoute && this.tabs.includes(categoryFromRoute)) {
      this.activeTab = categoryFromRoute;
    }
  }
};
</script>

<style scoped>
#body {
  font-family: 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  background-color: #1a1a1a;
  margin: 0;
  color: #f1f1f1;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
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

.cart-icon {
  background: none;
  border: none;
  cursor: pointer;
  font-size: 1.4rem;
  color: white;
  transition: all 0.2s ease;
  padding: 0.5rem;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.cart-icon:hover {
  background-color: rgba(255, 255, 255, 0.1);
  transform: scale(1.1);
  color: #ff4757;
}

.container {
  max-width: 1400px;
  margin: 2rem auto;
  padding: 0 2rem;
  flex: 1;
}

h1 {
  font-size: 2.5rem;
  margin-bottom: 2rem;
  color: white;
  position: relative;
  padding-bottom: 0.5rem;
}

h1::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  width: 100px;
  height: 4px;
  background-color: #ff4757;
  border-radius: 2px;
}

.top-nav {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 2rem;
  flex-wrap: wrap;
  gap: 1rem;
}

.tabs {
  display: flex;
  gap: 0.8rem;
  flex-wrap: wrap;
}

.tabs button {
  padding: 0.8rem 1.8rem;
  border: none;
  background-color: #333;
  color: white;
  font-weight: 600;
  border-radius: 6px;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
}

.tabs button:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
}

.tabs button.active {
  background-color: #ff4757;
  color: white;
}

.filters select {
  padding: 0.8rem 1.2rem;
  background-color: #333;
  color: white;
  font-weight: 600;
  border: 2px solid #444;
  border-radius: 6px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.filters select:hover {
  border-color: #ff4757;
}

.products {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 2rem;
  margin-top: 2rem;
}

.product-card {
  background-color: #2a2a2a;
  border-radius: 10px;
  padding: 1.5rem;
  transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
  display: flex;
  flex-direction: column;
  border: 1px solid #3a3a3a;
}

.product-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3);
  border-color: #ff4757;
}

.product-image {
  width: 100%;
  height: fit-content;
  background-color: #3a3a3a;
  border-radius: 8px;
  overflow: hidden;
  margin-bottom: 1.5rem;
  position: relative;
}

.product-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.5s ease;
}

.product-card:hover .product-image img {
  transform: scale(1.05);
}

.product-card h2 {
  font-size: 1.2rem;
  margin-bottom: 0.5rem;
  color: white;
}

.product-card span {
  font-size: 1.1rem;
  font-weight: 700;
  color: #ff4757;
  margin: 0.5rem 0;
}

.view-product {
  color: #ff4757;
  text-decoration: none;
  font-weight: 600;
  margin: 0.5rem 0;
  transition: all 0.2s ease;
}

.view-product:hover {
  text-decoration: underline;
}

.product-card button {
  margin-top: 1rem;
  padding: 0.8rem;
  background-color: #ff4757;
  color: white;
  border: none;
  border-radius: 6px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
  align-self: stretch;
}

.product-card button:hover {
  background-color: #ff6b81;
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(255, 71, 87, 0.3);
}

.toast {
  position: fixed;
  bottom: 2rem;
  left: 50%;
  transform: translateX(-50%);
  background-color: #ff4757;
  color: white;
  padding: 1rem 2rem;
  border-radius: 6px;
  font-weight: 600;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
  z-index: 1000;
  animation: slideUp 0.3s ease-out;
}

@keyframes slideUp {
  from {
    opacity: 0;
    transform: translate(-50%, 20px);
  }

  to {
    opacity: 1;
    transform: translate(-50%, 0);
  }
}

.modal {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.8);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 2000;
  padding: 2rem;
}

.modal-content {
  background-color: #2a2a2a;
  border-radius: 12px;
  padding: 2rem;
  max-width: 900px;
  width: 100%;
  max-height: 90vh;
  overflow-y: auto;
  display: flex;
  gap: 2rem;
  position: relative;
  border: 1px solid #ff4757;
}

.close {
  position: absolute;
  top: 1rem;
  right: 1rem;
  font-size: 2rem;
  color: #aaa;
  cursor: pointer;
  transition: all 0.2s ease;
  background: none;
  border: none;
  padding: 0.5rem;
}

.close:hover {
  color: #ff4757;
  transform: rotate(90deg);
}

.modal-left {
  flex: 1;
  min-width: 0;
}

.modal-left h2 {
  font-size: 1.8rem;
  margin-bottom: 1.5rem;
  color: white;
}

.modal-left p {
  line-height: 1.6;
  color: #ddd;
  margin-bottom: 1.5rem;
}

.modal-left table {
  width: 100%;
  border-collapse: collapse;
  margin: 1.5rem 0;
}

.modal-left table th {
  text-align: left;
  padding: 0.8rem;
  background-color: #ff4757;
  color: white;
  font-size: 1.1rem;
}

.modal-left table td {
  padding: 0.8rem;
  border-bottom: 1px solid #444;
  color: #ddd;
}

.modal-left table tr:nth-child(even) {
  background-color: #333;
}

.modal-left span {
  display: block;
  font-size: 1.5rem;
  font-weight: 700;
  color: #ff4757;
  margin: 1.5rem 0;
}

.modal-left button {
  padding: 1rem 2rem;
  background-color: #ff4757;
  color: white;
  border: none;
  border-radius: 6px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
  width: 100%;
}

.modal-left button:hover {
  background-color: #ff6b81;
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(255, 71, 87, 0.3);
}

.modal-right {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 1rem;
  min-width: 0;
}

.modal-right img {
  width: 100%;
  max-width: 300px;
  height: auto;
  border-radius: 8px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
  transition: all 0.3s ease;
}

.modal-right img:hover {
  transform: scale(1.02);
  box-shadow: 0 6px 12px rgba(0, 0, 0, 0.4);
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

.container {
  width: 100%;
}
  .cart-icon {
    display: none;
  }
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

  .tabs,
  .filters {
    width: 100%;
  }

  .tabs {
    overflow-x: auto;
    padding-bottom: 0.5rem;
  }

  .product-card {
    max-width: 256px;
  }
  
}

@media (max-width: 480px) {
  .product-card {
    width: 100%;
  }

  .modal-right img {
    max-width: 100%;
  }
}
</style>