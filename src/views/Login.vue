<template>
  <div id="body">
    <div class="container">
      <!-- Login Form -->
      <div
        id="login-form"
        class="form-container"
        :class="{ active: activeForm === 'login' }"
      >
        <h1>Welcome to PrimeFit</h1>
        <p>Your fitness journey starts here</p>

        <div class="toggle-buttons">
          <button
            id="login-btn"
            class="toggle-btn"
            @click="switchForm('login')"
          >
            Login
          </button>
          <button
            id="register-btn"
            class="toggle-btn"
            @click="switchForm('register')"
          >
            Create Account
          </button>
          <div
            id="slider"
            class="toggle-slider"
            :style="{ left: sliderPosition }"
          ></div>
        </div>

        <form @submit.prevent="handleLogin">
          <label for="username">Username</label>
          <input
            type="text"
            id="username"
            v-model="username"
            placeholder="Username"
            required
          />

          <label for="password">Password</label>
          <input
            type="password"
            id="password"
            v-model="loginPassword"
            placeholder="********"
            required
          />

          <div class="options">
            <label
              ><input type="checkbox" v-model="rememberMe" /> Remember me</label
            >
            <a href="#" @click.prevent="switchForm('reset')"
              >Forgot password?</a
            >
          </div>

          <button type="submit" class="sign-in">Sign In</button>
          <div v-if="errorMessage" class="error-message">
            {{ errorMessage }}
          </div>
        </form>
        <p class="divider">Or Use</p>
        <div class="social-buttons">
          <button class="social-btn google">
            <i class="fa-brands fa-google fa-lg"></i>
          </button>
          <button class="social-btn apple">
            <i class="fa-brands fa-apple fa-lg"></i>
          </button>
          <button class="social-btn facebook">
            <i class="fa-brands fa-facebook fa-lg"></i>
          </button>
        </div>
      </div>

      <!-- Register Form -->
      <div
        id="register-form"
        class="form-container"
        :class="{ active: activeForm === 'register' }"
      >
        <h1>Create Account</h1>
        <p>Join PrimeFit today</p>

        <div class="toggle-buttons">
          <button
            id="login-btn"
            class="toggle-btn"
            @click="switchForm('login')"
          >
            Login
          </button>
          <button
            id="register-btn"
            class="toggle-btn"
            @click="switchForm('register')"
          >
            Create Account
          </button>
          <div
            id="slider"
            class="toggle-slider"
            :style="{ left: sliderPosition }"
          ></div>
        </div>

        <form @submit.prevent="handleRegister">
          <label for="register-email">Email</label>
          <input
            type="email"
            id="register-email"
            v-model="registerEmail"
            placeholder="your@email.com"
            required
          />

          <label for="register-password">Password</label>
          <input
            type="password"
            id="register-password"
            v-model="registerPassword"
            placeholder="********"
            required
          />

          <label for="confirm-password">Confirm Password</label>
          <input
            type="password"
            id="confirm-password"
            v-model="confirmPassword"
            placeholder="********"
            required
          />

          <button type="submit" class="sign-in">Create Account</button>
        </form>
        <p class="divider">Or sign up with</p>
        <div class="social-buttons">
          <button class="social-btn google">
            <i class="fa-brands fa-google fa-lg"></i>
          </button>
          <button class="social-btn apple">
            <i class="fa-brands fa-apple fa-lg"></i>
          </button>
          <button class="social-btn facebook">
            <i class="fa-brands fa-facebook fa-lg"></i>
          </button>
        </div>
      </div>

      <!-- Reset Password Form -->
      <div
        id="reset-form"
        class="form-container"
        :class="{ active: activeForm === 'reset' }"
      >
        <h1>Reset Password</h1>
        <p>Enter your email to reset your password</p>

        <form @submit.prevent="handleReset">
          <label for="reset-email">Email</label>
          <input
            type="email"
            id="reset-email"
            v-model="resetEmail"
            placeholder="your@email.com"
            required
          />

          <button type="submit" class="sign-in">Send Reset Link</button>
        </form>
        <p class="divider">
          Remembered your password?
          <a href="#" @click.prevent="switchForm('login')">Login</a>
        </p>
      </div>

      <!-- Success Modal -->
      <div id="success-modal" class="modal" v-if="showSuccessModal">
        <div class="modal-content">
          <span class="close" @click="closeModal">&times;</span>
          <h2>{{ modalMessage }}😊</h2>
        </div>
      </div>

      <!-- PrimeFit Membership Form -->
      <div
        id="membership-form"
        class="form-container"
        :class="{ active: activeForm === 'membership' }"
      >
        <h1>PrimeFit Membership</h1>
        <p>Fill in your details</p>

        <form @submit.prevent="handleMembership">
          <label for="full-name">Full Name</label>
          <input
            type="text"
            id="full-name"
            v-model="fullName"
            placeholder="Name"
            required
          />

          <label for="age">Age</label>
          <input
            type="number"
            id="age"
            v-model="age"
            placeholder="Age"
            required
          />

          <label for="address">Address</label>
          <input
            type="text"
            id="address"
            v-model="address"
            placeholder="Address"
            required
          />

          <label for="gender">Gender</label>
          <select id="gender" v-model="gender" required>
            <option value="">Select Gender</option>
            <option value="female">Female</option>
            <option value="male">Male</option>
          </select>

          <label for="phone">Phone Number</label>
          <input
            type="text"
            id="phone"
            v-model="phone"
            placeholder="123-456-7890"
            required
          />

          <button type="submit" class="sign-in">Submit Form</button>
        </form>
        <p class="divider">
          Already have an account?
          <a href="#" @click.prevent="switchForm('login')">Login</a>
        </p>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import { mapActions, mapMutations } from "vuex";
const API = import.meta.env.VITE_API_URL;

export default {
  name: "LoginView",
  data() {
    return {
      activeForm: "login",
      sliderPosition: "0%",
      username: "",
      loginPassword: "",
      rememberMe: false,
      registerEmail: "",
      registerPassword: "",
      confirmPassword: "",
      resetEmail: "",
      showSuccessModal: false,
      modalMessage: "",
      errorMessage: "",
      fullName: "",
      age: "",
      address: "",  // Fixed typo from 'adress' to 'address'
      gender: "",
      phone: "",
    };
  },
  created() {
    const savedForm = localStorage.getItem("activeForm");
    if (savedForm) {
      this.activeForm = savedForm;
      if (savedForm === "login") this.sliderPosition = "0%";
      else if (savedForm === "register") this.sliderPosition = "50%";
      else this.sliderPosition = "100%";
    }
  },
  methods: {
    ...mapActions(["addUsers", "updateUser", "loginUser", "logoutUser"]),
    ...mapMutations(["setToken", "setUser"]),

    switchForm(form) {
      this.activeForm = form;
      localStorage.setItem("activeForm", form);
      this.errorMessage = "";
      if (form === "login") {
        this.sliderPosition = "0%";
      } else if (form === "register") {
        this.sliderPosition = "50%";
      } else if (form === "reset") {
        this.sliderPosition = "100%";
      } else if (form === "membership") {
        this.sliderPosition = "100%";
      }
    },

    openModalWithMessage(message) {
      this.modalMessage = message;
      this.showSuccessModal = true;
    },

    async handleLogin() {
      this.errorMessage = "";
      try {
        const response = await axios.post(`${API}users/login`, {
          username: this.username,
          password: this.loginPassword,
        });

        if (response.data.token) {
          // Store token in localStorage
          localStorage.setItem("token", response.data.token);
          
          // Update Vuex state using mutations
          this.setToken(response.data.token);
          this.setUser(response.data.user);

          this.openModalWithMessage("Logged In Successfully");

          setTimeout(() => {
            this.showSuccessModal = false;
            this.$router.push("/");
          }, 2000);
        }
      } catch (error) {
        this.errorMessage =
          error.response?.data?.message ||
          "Invalid username or password. Please try again.";
      }
    },

    async handleRegister() {
      this.errorMessage = "";

      if (this.registerPassword !== this.confirmPassword) {
        this.errorMessage = "Passwords do not match.";
        return;
      }

      if (!this.registerEmail || !this.registerPassword) {
        this.errorMessage = "Please complete all required fields.";
        return;
      }

      try {
        await this.addUsers({
          email: this.registerEmail,
          password: this.registerPassword,
        });

        this.openModalWithMessage("Registered Successfully");

        setTimeout(() => {
          this.showSuccessModal = false;
          this.switchForm("membership");
        }, 2000);
      } catch (error) {
        this.errorMessage = error.message || "Registration failed.";
      }
    },

    async handleMembership() {
      this.errorMessage = "";
      const payload = {
        name: this.fullName,
        email: this.registerEmail,
        address: this.address || "N/A",
        age: this.age,
        gender: this.gender,
        phone: this.phone,
      };

      try {
        await this.updateUser(payload);

        this.openModalWithMessage("Subscribed Successfully");

        // Use the loginUser action from your store
        const loginPayload = {
          username: this.fullName,  // Keep as fullName since your backend might expect it
          password: this.registerPassword,
        };

        setTimeout(async () => {
          try {
            await this.loginUser(loginPayload);
            
            this.showSuccessModal = false;
            this.activeForm = "login";
            this.$router.push("/");
          } catch (error) {
            this.errorMessage = "Auto-login failed after subscription.";
            this.showSuccessModal = false;
            // Still redirect to login form for manual login
            this.switchForm("login");
          }
        }, 2000);
      } catch (error) {
        this.errorMessage =
          error.message || "Failed to update profile. Please try again.";
      }
    },

    async handleReset() {
      this.errorMessage = "";
      
      if (!this.resetEmail) {
        this.errorMessage = "Please enter your email address.";
        return;
      }

      try {
        // Add your password reset API call here when backend is ready
        // await axios.post(`${API}users/reset-password`, {
        //   email: this.resetEmail
        // });
        
        this.openModalWithMessage("Reset link sent to your email");
        
        setTimeout(() => {
          this.showSuccessModal = false;
          this.switchForm("login");
        }, 2000);
        
        console.log("Reset:", this.resetEmail);
        
      } catch (error) {
        this.errorMessage = error.response?.data?.message || "Failed to send reset email.";
      }
    },

    closeModal() {
      this.showSuccessModal = false;
    },
  },
};
</script>

<style scoped>
#body {
  font-family: "Poppins", Arial, sans-serif;
  background-color: #333;
  display: flex;
  align-items: center;
  justify-content: center;
  min-height: 100vh;
  margin: 0;
  background-image: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)),
    url("../assets/images/gym-background.jpg");
  background-size: cover;
  background-position: center;
}

.container {
  background-color: rgba(51, 51, 51, 0.9);
  border-radius: 12px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
  padding: 30px;
  width: 380px;
  max-width: 95%;
  text-align: center;
  position: relative;
  backdrop-filter: blur(5px);
  border: 1px solid rgba(255, 255, 255, 0.1);
  animation: fadeIn 0.5s ease-out;
}

@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

h1 {
  font-size: 28px;
  margin-bottom: 10px;
  color: white;
  font-weight: 700;
  letter-spacing: 0.5px;
}

p {
  color: #bbb;
  margin: 0 0 25px;
  font-size: 0.95rem;
}

.toggle-buttons {
  display: flex;
  position: relative;
  margin-bottom: 30px;
  background: rgba(0, 0, 0, 0.2);
  border-radius: 30px;
  padding: 5px;
}

.toggle-btn {
  flex: 1;
  padding: 12px;
  cursor: pointer;
  font-weight: 600;
  border: none;
  background: transparent;
  outline: none;
  position: relative;
  color: #ddd;
  transition: all 0.3s ease;
  z-index: 1;
}

.toggle-btn:hover {
  color: white;
}

.toggle-slider {
  position: absolute;
  top: 5px;
  left: 0;
  width: 50%;
  height: calc(100% - 10px);
  background-color: crimson;
  border-radius: 30px;
  transition: all 0.4s cubic-bezier(0.68, -0.55, 0.265, 1.55);
  z-index: 0;
}

label {
  display: block;
  margin-bottom: 8px;
  text-align: left;
  color: #ddd;
  font-size: 0.9rem;
  font-weight: 500;
}

input[type="text"],
input[type="number"],
input[type="email"],
input[type="password"],
select {
  width: 100%;
  padding: 12px 15px;
  margin-bottom: 20px;
  border-radius: 8px;
  border: 1px solid #444;
  background-color: rgba(255, 255, 255, 0.1);
  color: white;
  font-size: 0.95rem;
  transition: all 0.3s ease;
}

input:focus,
select:focus {
  border-color: crimson;
  box-shadow: 0 0 0 3px rgba(220, 20, 60, 0.2);
  outline: none;
}

select {
  appearance: none;
  background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="%23ddd" stroke-width="2"><polyline points="6 9 12 15 18 9"/></svg>');
  background-repeat: no-repeat;
  background-position: right 15px center;
}

.options {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 0.85rem;
  margin-bottom: 20px;
  color: #bbb;
}

.options label {
  display: flex;
  align-items: center;
  gap: 5px;
  cursor: pointer;
}

.options a {
  color: #ddd;
  text-decoration: none;
  transition: color 0.3s ease;
}

.options a:hover {
  color: crimson;
}

.sign-in {
  width: 100%;
  padding: 14px;
  background-color: crimson;
  color: white;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  font-weight: 600;
  font-size: 1rem;
  letter-spacing: 0.5px;
  transition: all 0.3s ease;
  margin-top: 10px;
  text-transform: uppercase;
}

.sign-in:hover {
  background-color: #e63946;
  transform: translateY(-2px);
  box-shadow: 0 5px 15px rgba(220, 20, 60, 0.4);
}

.sign-in:active {
  transform: translateY(0);
}

.divider {
  position: relative;
  margin: 25px 0;
  color: #777;
  font-size: 0.85rem;
}

.divider::before,
.divider::after {
  content: "";
  position: absolute;
  top: 50%;
  width: 30%;
  height: 1px;
  background-color: #444;
}

.divider::before {
  left: 0;
}

.divider::after {
  right: 0;
}

.social-buttons {
  display: flex;
  justify-content: center;
  gap: 15px;
  margin-top: 20px;
}

.social-btn {
  width: 45px;
  height: 45px;
  border-radius: 50%;
  border: none;
  color: white;
  font-size: 1.2rem;
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
}

.social-btn:hover {
  transform: translateY(-3px);
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
}

.google {
  background-color: #db4437;
}

.apple {
  background-color: #000;
}

.facebook {
  background-color: #3b5998;
}

.error-message {
  color: #ff6b6b;
  margin: 15px 0;
  font-size: 0.9rem;
  font-weight: 500;
  padding: 10px;
  background-color: rgba(255, 0, 0, 0.1);
  border-radius: 5px;
  border-left: 3px solid #ff6b6b;
}

/* Modal styles */
.modal {
  position: fixed;
  z-index: 1000;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgba(0, 0, 0, 0.7);
  display: flex;
  align-items: center;
  justify-content: center;
  animation: fadeIn 0.3s ease-out;
}

.modal-content {
  background-color: #333;
  padding: 30px;
  border-radius: 12px;
  box-shadow: 0 15px 30px rgba(0, 0, 0, 0.4);
  max-width: 400px;
  width: 90%;
  text-align: center;
  position: relative;
  animation: slideUp 0.4s ease-out;
  border: 1px solid rgba(255, 255, 255, 0.1);
}

@keyframes slideUp {
  from {
    transform: translateY(30px);
    opacity: 0;
  }
  to {
    transform: translateY(0);
    opacity: 1;
  }
}

.modal-content h2 {
  margin-top: 0;
  font-size: 24px;
  color: white;
}

.modal-content p {
  font-size: 16px;
  color: #bbb;
  margin: 15px 0 0;
}

.close {
  position: absolute;
  top: 15px;
  right: 20px;
  font-size: 28px;
  color: #bbb;
  cursor: pointer;
  transition: all 0.3s ease;
}

.close:hover {
  color: crimson;
  transform: rotate(90deg);
}

/* Form container transitions */
.form-container {
  display: none;
  animation: fadeIn 0.4s ease-out;
}

.form-container.active {
  display: block;
}

/* Responsive adjustments */
@media (max-width: 480px) {
  .container {
    padding: 25px 20px;
    width: 90%;
  }

  h1 {
    font-size: 24px;
  }

  .toggle-btn {
    padding: 10px;
    font-size: 0.9rem;
  }

  input,
  select,
  .sign-in {
    padding: 12px;
  }
}
</style>
