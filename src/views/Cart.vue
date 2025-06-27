<template>
  <!-- Same template structure remains unchanged -->
  <div id="body">
    <div class="cart-items">
      <div id="cart-items">
        <h1>Shopping Cart</h1>
        <div v-if="cart.length === 0" class="empty">Your cart is empty.</div>
        <div v-for="(product, index) in cart" :key="index" class="product">
          <img class="product-image" :src="product.image_url.images[0]" :alt="product.name" />
          <div class="product-details">
            <h2>{{ product.name }}</h2>
            <p>In Stock: {{ product.stock }}, {{ product.supplier }}</p>
            <span>R{{ (product.price * 1000).toLocaleString("en-ZA", {
              minimumFractionDigits: 2, maximumFractionDigits:
              2 }) }}</span>
          </div>
          <div class="quantity-controls">
            <button @click="decreaseQuantity(index)">-</button>
            <span class="quantity">{{ product.quantity }}</span>
            <button @click="increaseQuantity(index)">+</button>
            <button @click="removeFromCart(index)">🗑️</button>
          </div>
        </div>
      </div>
      <div class="wrapper">
        <div class="order-summary">
          <h2>Order Summary</h2>
          <div v-for="(product, index) in cart" :key="index" class="summary-row">
            <span>{{ product.name }}</span>
          </div>
          <div class="summary-row">
            <span>Items</span>
            <span>{{ totalQuantity }}</span>
            <span>R{{ subtotal.toLocaleString("en-ZA", { minimumFractionDigits: 2, maximumFractionDigits: 2 }) }}</span>

          </div>
          <div class="summary-row">
            <span>Delivery</span>
            <span>R{{ delivery.toFixed(2) }}</span>
          </div>
          <div class="summary-row">
            <span>Tax</span>
            <span>R{{ tax.toFixed(2) }}</span>
          </div>
          <hr />
          <div class="summary-row total">
            <span>Total</span>
            <span>R{{ subtotal.toLocaleString("en-ZA", { minimumFractionDigits: 2, maximumFractionDigits: 2 }) }}</span>
          </div>
          <button class="checkout" @click="proceedToCheckout">Proceed to Checkout</button>
          <div class="card-info">
            <i class="fa-brands fa-cc-visa"></i>
            <i class="fa-brands fa-cc-mastercard"></i>
            <i class="fa-brands fa-cc-amex"></i>
            <i class="fa-brands fa-cc-paypal"></i>
          </div>
        </div>
      </div>
    </div>

    <!-- Toast Notification -->
    <div class="toast" v-show="toastVisible">{{ toastMessage }}</div>
  </div>
</template>

<script>
/* Script remains exactly the same */
export default {
  name: "CartView",
  data() {
    return {
      cart: JSON.parse(localStorage.getItem("cart")) || [],
      toastVisible: false,
      toastMessage: "",
    };
  },
  computed: {
    subtotal() {
      return this.cart.reduce((sum, product) => sum + product.price * product.quantity, 0) * 1000;
    },
    tax() {
      return this.subtotal * 0.15; // 15% tax rate
    },
    delivery() {
      return this.subtotal > 0 ? 30.0 : 0;
    },
    total() {
      return this.subtotal + this.delivery + this.tax;
    },
    totalQuantity() {
      return this.cart.reduce((sum, product) => sum + product.quantity, 0);
    }
  },

  methods: {
    showToast(message) {
      this.toastMessage = message;
      this.toastVisible = true;

      setTimeout(() => {
        this.toastVisible = false;
        this.toastMessage = "";
      }, 2000);
    },
    increaseQuantity(index) {
      this.cart[index].quantity++;
      this.updateCart();
      this.showToast(`${this.cart[index].name} quantity increased!`);
    },
    decreaseQuantity(index) {
      if (this.cart[index].quantity > 1) {
        this.cart[index].quantity--;
        this.showToast(`${this.cart[index].name} quantity decreased!`);
      } else {
        this.removeFromCart(index);
      }
      this.updateCart();
    },
    removeFromCart(index) {
      this.showToast(`${this.cart[index].name} removed from cart!`);
      this.cart.splice(index, 1);
      this.updateCart();
    },
    updateCart() {
      localStorage.setItem("cart", JSON.stringify(this.cart));
    },
    proceedToCheckout() {
      if (this.cart.length === 0) {
        this.showToast("Your cart is empty! Please add items to proceed.");
      } else {
        this.$router.push({
          path: '/payment',
          query: {
            subtotal: this.subtotal,
            tax: this.tax,
            delivery: this.delivery,
            total: this.total,
            totalQuantity: this.totalQuantity,
          },
        });
      }
    },
  },
  watch: {
    cart(newCart) {
      localStorage.setItem("cart", JSON.stringify(newCart)); // Sync cart changes to localStorage
    },
  },
  created() {
    this.cart = JSON.parse(localStorage.getItem("cart")) || []; // Retrieve cart data when component is created
  },
};
</script>

<style scoped>
#body {
  font-family: 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  background-color: #333;
  margin: 0;
  padding: 2rem;
  min-height: 100vh;
  display: flex;
  justify-content: center;
  align-items: flex-start;
}

h1 {
  color: #e63946;
  font-size: 2rem;
  margin-bottom: 1.5rem;
  font-weight: 600;
  text-align: left;
}

.cart-items {
  display: flex;
  width: 90%;
  max-width: 1200px;
  border-radius: 12px;
  justify-content: space-between;
  padding: 2rem;
  height: fit-content;
  background-color: white;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  gap: 2rem;
}

#cart-items {
  flex: 1;
  padding-right: 2rem;
}

.empty {
  color: #6c757d;
  font-size: 1.1rem;
  padding: 2rem 0;
  text-align: center;
}

.product {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 1.2rem 0;
  border-bottom: 1px solid #e9ecef;
  transition: all 0.2s ease;
}

.product:hover {
  background-color: #f8f9fa;
}

.product-image {
  width: 100px;
  height: 100px;
  border-radius: 12px;
  object-fit: cover;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.5);
}

.product-details {
  flex-grow: 1;
  padding: 0 1.5rem;
}

.product-details h2 {
  font-size: 1.1rem;
  font-weight: 500;
  margin-bottom: 0.5rem;
  color: #212529;
}

.product-details p {
  font-size: 0.9rem;
  color: #6c757d;
  margin-bottom: 0.5rem;
}

.product-details span {
  font-weight: 600;
  color: #2b2d42;
  font-size: 1rem;
}

.quantity-controls {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.quantity-controls button {
  background: #d3d3d3;
  color: #495057;
  border: none;
  padding: 0.5rem 0.8rem;
  border-radius: 6px;
  cursor: pointer;
  font-size: 1rem;
  transition: all 0.2s ease;
  display: flex;
  align-items: center;
  justify-content: center;
}

.quantity-controls button:hover {
  background: #e9ecef;
}

.quantity-controls button:active {
  transform: scale(0.95);
}

.quantity {
  min-width: 1.5rem;
  text-align: center;
  font-weight: 500;
}

.wrapper {
  width: 35%;
  min-width: 300px;
}

.order-summary {
  background-color: white;
  border-radius: 12px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  padding: 1.5rem;
  position: sticky;
  top: 2rem;
}

.order-summary h2 {
  font-size: 1.3rem;
  font-weight: 600;
  margin-bottom: 1.5rem;
  color: #212529;
}

.summary-row {
  display: flex;
  justify-content: space-between;
  padding: 0.6rem 0;
  font-size: 0.95rem;
}

.summary-row span:first-child {
  color: #6c757d;
}

.summary-row span:last-child {
  font-weight: 500;
  color: #212529;
}

hr {
  border: none;
  height: 1px;
  background-color: #e9ecef;
  margin: 1rem 0;
}

.total {
  font-weight: 600;
  font-size: 1.1rem;
  color: #2b2d42;
}

.checkout {
  width: 100%;
  background: #e63946;
  color: white;
  border: none;
  padding: 0.8rem;
  border-radius: 8px;
  cursor: pointer;
  margin-top: 1.5rem;
  font-weight: 500;
  font-size: 1rem;
  transition: all 0.2s ease;
}

.checkout:hover {
  background: #d62839;
  transform: translateY(-2px);
}

.checkout:active {
  transform: translateY(0);
}

.card-info {
  display: flex;
  justify-content: center;
  gap: 1rem;
  margin-top: 1.5rem;
  color: #6c757d;
  font-size: 1.5rem;
}

/* Toast Styling */
.toast {
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background: rgba(0, 0, 0, 0.85);
  color: white;
  padding: 1rem 1.5rem;
  border-radius: 8px;
  font-size: 1rem;
  z-index: 1000;
  animation: fade-in 0.3s ease-in-out;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

@keyframes fade-in {
  from {
    opacity: 0;
    transform: translate(-50%, -60%);
  }
  to {
    opacity: 1;
    transform: translate(-50%, -50%);
  }
}

/* Responsive Styles */
@media only screen and (max-width: 992px) {
  .cart-items {
    flex-direction: column;
    width: 95%;
  }
  
  #cart-items {
    padding-right: 0;
    margin-bottom: 2rem;
  }
  
  .wrapper {
    width: 100%;
  }
}

@media only screen and (max-width: 768px) {
  .product {
    flex-wrap: wrap;
  }
  
  .product-details {
    width: 60%;
    padding: 0 1rem;
  }
  
  .quantity-controls {
    width: 100%;
    justify-content: flex-end;
    margin-top: 1rem;
  }
}

@media only screen and (max-width: 576px) {
  #body {
    padding: 1rem;
  }
  
  .cart-items {
    padding: 1.5rem;
  }
  
  .product {
    flex-direction: column;
    align-items: flex-start;
  }
  
  .product-image {
    margin-bottom: 1rem;
  }
  
  .product-details {
    width: 100%;
    padding: 0;
    margin-bottom: 1rem;
  }
  
  .quantity-controls {
    width: 100%;
    justify-content: space-between;
  }
  
  .order-summary {
    padding: 1.25rem;
  }
}
</style>