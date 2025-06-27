<template>
  <div id="body">
    <div class="container">
      <Toast ref="toast" />
      <h1>Complete Your Payment</h1>

      <!-- Order Summary Section -->
      <div class="order-summary">
        <h2>Order Summary</h2>
        <div class="summary-row">
          <span>Items:</span>
          <span>{{ orderSummary.totalQuantity }}</span>
          <span>R{{ orderSummary.subtotal.toFixed(2) }}</span>
        </div>
        <div class="summary-row">
          <span>Tax:</span>
          <span>R{{ orderSummary.tax.toFixed(2) }}</span>
        </div>
        <div class="summary-row">
          <span>Delivery:</span>
          <span>R{{ orderSummary.delivery.toFixed(2) }}</span>
        </div>
        <hr />
        <div class="summary-row total">
          <span>Total:</span>
          <span>R{{ orderSummary.total.toFixed(2) }}</span>
        </div>
      </div>

      <!-- Plan Section -->
      <div class="plan">
        <h2>{{ $route.query.name }} - {{ $route.query.duration }}</h2>
        <p>Monthly subscription • Cancel anytime</p>
        <p class="amount">R{{ $route.query.price }}</p>
      </div>

      <!-- Payment Form -->
      <form @submit.prevent="handlePayment">
        <input type="text" v-model="cardNumber" placeholder="Card Number" required aria-label="Card Number" />
        <div class="expiry-cvc">
          <input type="text" v-model="expiryDate" placeholder="MM/YY" required aria-label="Expiry Date" />
          <input type="text" v-model="cvc" placeholder="CVC" required aria-label="CVC" />
        </div>

        <!-- Cryptocurrency Selection -->
        <h3>Cryptocurrency</h3>
        <select v-model="selectedCrypto" @change="toggleCryptoAddress" aria-label="Select Cryptocurrency">
          <option value="" disabled>Select a cryptocurrency</option>
          <option value="bitcoin">Pay with Bitcoin</option>
          <option value="ethereum">Pay with Ethereum</option>
          <option value="bitcash">Pay with BitCash</option>
        </select>

        <input v-if="showCryptoAddress" type="text" v-model="cryptoAddress"
          placeholder="Enter your cryptocurrency address" required aria-label="Cryptocurrency Address" />

        <!-- Other Payment Options -->
        <h3>Other Payment Options</h3>
        <button type="submit" class="complete-payment" :disabled="!isFormValid">Complete Payment</button>
      </form>

      <p class="footer-note">Secure payment processed by Payfast.</p>
      <p class="footer">© 2025 PrimeFit. All rights reserved.</p>
    </div>
  </div>

  <!-- Payment Success Modal -->
  <div v-if="showModal" class="modal-overlay" aria-labelledby="payment-modal">
    <div class="modal">
      <h2>Payment Successful</h2>
      <p>Your payment of R{{ orderSummary.total.toFixed(2) }} has been processed successfully.</p>
      <button @click="closeModal" aria-label="Close Modal">OK</button>
    </div>
  </div>
</template>

<script>
import Toast from '../components/Toast.vue';

export default {
  name: "PaymentView",
  components: {
    Toast,
  },
  data() {
    return {
      cardNumber: '',
      expiryDate: '',
      cvc: '',
      selectedCrypto: '',
      showCryptoAddress: false,
      cryptoAddress: '',
      showModal: false,
    };
  },
  computed: {
    orderSummary() {
      return {
        name: this.$route.query.name,
        price: parseFloat(this.$route.query.price),
        subtotal: parseFloat(this.$route.query.subtotal) || 0,
        tax: parseFloat(this.$route.query.tax) || 0,
        delivery: parseFloat(this.$route.query.delivery) || 0,
        total: parseFloat(this.$route.query.total) || 0,
        totalQuantity: parseInt(this.$route.query.totalQuantity) || 0,
      };
    },
    // Validate form state
    isFormValid() {
      return this.cardNumber && this.expiryDate && this.cvc && (this.selectedCrypto || this.cardNumber.length === 16);
    }
  },
  methods: {
    toggleCryptoAddress() {
      this.showCryptoAddress = this.selectedCrypto !== '';
    },
    handlePayment() {
      if (!this.isFormValid) {
        this.$refs.toast.show("Please complete all required fields.");
        return;
      }
      this.showModal = true;
    },
    closeModal() {
      this.showModal = false;
    }
  },
  created() {
    console.log("Route Query:", this.$route.query);
  }
};
</script>

<style scoped>
#body {
  font-family: 'Poppins', Arial, sans-serif;
  background-color: #333;
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  margin: 0;
  background-image: linear-gradient(rgba(0, 0, 0, 0.8), rgba(0, 0, 0, 0.8)), 
                    url('../assets/images/gym-background.jpg');
  background-size: cover;
  background-position: center;
}

.container {
  background-color: rgba(255, 255, 255, 0.949);
  padding: 40px;
  border-radius: 12px;
  box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
  width: 450px;
  max-width: 95%;
  margin: 30px auto;
  border: 1px solid rgba(255, 255, 255, 0.2);
  animation: fadeInUp 0.5s ease-out;
}

@keyframes fadeInUp {
  from { opacity: 0; transform: translateY(20px); }
  to { opacity: 1; transform: translateY(0); }
}

h1 {
  text-align: center;
  margin-bottom: 25px;
  color: #333;
  font-size: 28px;
  font-weight: 700;
  letter-spacing: 0.5px;
}

.order-summary {
  background-color: #f8f9fa;
  padding: 25px;
  border-radius: 10px;
  margin-bottom: 25px;
  box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
  border: 1px solid #e9ecef;
}

.order-summary h2 {
  font-size: 1.3rem;
  margin-bottom: 20px;
  color: #333;
  font-weight: 600;
  border-bottom: 2px solid crimson;
  padding-bottom: 10px;
}

.summary-row {
  display: flex;
  justify-content: space-between;
  padding: 12px 0;
  font-size: 0.95rem;
  color: #555;
}

.summary-row.total {
  font-weight: 700;
  font-size: 1.1rem;
  margin-top: 15px;
}

.summary-row.total span:last-child {
  color: crimson;
  font-size: 1.3rem;
}

hr {
  border: 0;
  height: 1px;
  background: linear-gradient(to right, transparent, #ddd, transparent);
  margin: 20px 0;
}

.plan {
  background-color: #f8f9fa;
  padding: 20px;
  border-radius: 10px;
  margin-bottom: 25px;
  box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
  border: 1px solid #e9ecef;
}

.plan h2 {
  font-size: 1.25rem;
  color: #333;
  margin-bottom: 10px;
  font-weight: 600;
}

.plan p {
  color: #666;
  font-size: 0.9rem;
  margin-bottom: 5px;
}

.plan .amount {
  font-size: 1.8rem;
  font-weight: 700;
  color: crimson;
  text-align: right;
  margin-top: 10px;
}

form {
  margin-top: 30px;
}

h3 {
  font-size: 1.1rem;
  color: #333;
  margin: 20px 0 10px;
  font-weight: 600;
}

input {
  width: 100%;
  padding: 14px 15px;
  margin: 8px 0 15px;
  border: 2px solid #ddd;
  border-radius: 8px;
  font-size: 0.95rem;
  transition: all 0.3s ease;
  background-color: #fff;
}

input:focus {
  border-color: crimson;
  box-shadow: 0 0 0 3px rgba(220, 20, 60, 0.2);
  outline: none;
}

.expiry-cvc {
  display: flex;
  gap: 15px;
}

.expiry-cvc input {
  flex: 1;
}

select {
  width: 100%;
  padding: 14px 15px;
  margin: 8px 0 15px;
  border: 2px solid #ddd;
  border-radius: 8px;
  font-size: 0.95rem;
  background-color: #fff;
  cursor: pointer;
  transition: all 0.3s ease;
  appearance: none;
  background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="%23555" stroke-width="2"><polyline points="6 9 12 15 18 9"/></svg>');
  background-repeat: no-repeat;
  background-position: right 15px center;
}

select:focus {
  border-color: crimson;
  box-shadow: 0 0 0 3px rgba(220, 20, 60, 0.2);
}

.complete-payment {
  width: 100%;
  padding: 16px;
  background-color: crimson;
  color: white;
  border: none;
  border-radius: 8px;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  margin-top: 20px;
  transition: all 0.3s ease;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  box-shadow: 0 4px 10px rgba(220, 20, 60, 0.3);
}

.complete-payment:hover:not(:disabled) {
  background-color: #e63946;
  transform: translateY(-2px);
  box-shadow: 0 6px 15px rgba(220, 20, 60, 0.4);
}

.complete-payment:active:not(:disabled) {
  transform: translateY(0);
}

.complete-payment:disabled {
  background-color: #ccc;
  cursor: not-allowed;
  opacity: 0.7;
}

.footer-note {
  text-align: center;
  margin: 25px 0 10px;
  color: #777;
  font-size: 0.85rem;
}

.footer {
  text-align: center;
  color: #999;
  font-size: 0.8rem;
  margin-top: 30px;
}

/* Modal styles */
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.7);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
  animation: fadeIn 0.3s ease-out;
}

@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}

.modal {
  background: white;
  padding: 30px;
  border-radius: 12px;
  text-align: center;
  max-width: 400px;
  width: 90%;
  box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
  animation: slideUp 0.4s ease-out;
}

@keyframes slideUp {
  from { transform: translateY(30px); opacity: 0; }
  to { transform: translateY(0); opacity: 1; }
}

.modal h2 {
  color: #333;
  margin-bottom: 15px;
  font-size: 1.5rem;
}

.modal p {
  color: #555;
  margin-bottom: 25px;
  font-size: 1rem;
}

.modal button {
  padding: 12px 30px;
  background-color: crimson;
  color: white;
  border: none;
  border-radius: 30px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
}

.modal button:hover {
  background-color: #e63946;
  transform: translateY(-2px);
}

/* Responsive adjustments */
@media (max-width: 480px) {
  .container {
    padding: 25px 20px;
  }
  
  h1 {
    font-size: 24px;
  }
  
  .expiry-cvc {
    flex-direction: column;
    gap: 0;
  }
  
  .expiry-cvc input {
    width: 100%;
  }
}
</style>