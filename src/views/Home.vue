<template>
    <TrainerDetails />
    <div id="body">
        <header>
            <div class="navbar-left">
                <h1><a href="#" class="brand-name">Prime<span>Fit</span></a></h1>
                <nav :class="{ open: isMenuOpen }">
                    <router-link to="/">Home</router-link>
                    <router-link to="/shop">Shop</router-link>
                    <router-link to="/plans">Subscriptions</router-link>
                    <router-link v-if="!isLoggedIn" to="/login" class="mobile-login">Login</router-link><a v-else href="#" class="mobile-login" @click.prevent="logout">Logout</a>
                </nav>
            </div>

            <div class="navbar-right">
                <button class="login-btn" v-if="!isLoggedIn" @click="Login">Log In</button>
                <button class="login-btn" v-else @click="logout">Log Out</button>
                <div class="burger" @click="toggleMenu">
                    <span></span>
                    <span></span>
                    <span></span>
                </div>
            </div>
        </header>

        <div class="container">

            <div class="hero">
                <div class="hero-text">
                    <h1>Your Complete Fitness Solution</h1>
                    <p>All from the comfort of your home!</p>
                    <button @click="goToPlans">Subscribe Now</button>
                </div>
            </div>
            <div class="categories">
                <div class="category">
                    <img src="https://github.com/TwinnJoe/PrimeFit/blob/main/src/assets/images/Categories/category-gym%20equipment.jpg?raw=true" alt="Equipment Image" />
                    <h3>Gym Equipment</h3>
                </div>
                <div class="category">
                    <img src="https://github.com/TwinnJoe/PrimeFit/blob/main/src/assets/images/Categories/category-apparl.jpg?raw=true" alt="Apparel Image" />
                    <h3>Gym Apparel</h3>
                </div>
                <div class="category">
                    <img src="https://github.com/TwinnJoe/PrimeFit/blob/main/src/assets/images/Categories/acccesories_category.jpg?raw=true" alt="Accessories Image" />
                    <h3>Accessories</h3>
                </div>
                <div class="category">
                    <img src="https://github.com/TwinnJoe/PrimeFit/blob/main/src/assets/images/Categories/category-training.jpg?raw=true" alt="Training Image" />
                    <h3>Personal Training</h3>
                </div>
            </div>
            <h2 class="title">Featured Products</h2>
            <div v-if="isLoading">
                <p style="color: white;">Loading...</p>
            </div>
            <div v-else class="featured-products">

                <div class="product" v-for="product in safeProducts" :key="product.product_id">
                    <img :src="product.image_url.images[0]" alt="Product Image" />
                    <h2>{{ product.name }}</h2>
                    <p>R{{ product.price }}</p>
                </div>

            </div>
            <h2 class="title">Meet Our Trainers</h2>




            <div class="wrapper">
                <div class="card" v-for="trainer in trainers" :key="trainer.trainer_id">
                    <img :src="trainer.image_url" :alt="trainer.name" />
                    <div class="overlay">
                        <button class="view-btn" @click="openModal(trainer)">View</button>
                    </div>
                </div>
            </div>


            <TrainerDetails v-if="selectedTrainer" :trainer="selectedTrainer" :isVisible="isModalVisible"
                @close="closeModal" />

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
    </div>
</template>


<script>
import TrainerDetails from '../components/TrainerDetails.vue';
import { mapState, mapActions } from 'vuex';

export default {
    name: "HomeView",
    components: {
        TrainerDetails,
    },
    data() {
        return {
            selectedTrainer: null,
            isModalVisible: false,
            isLoading: true,
            isMenuOpen: false
        };
    },
    computed: {
        ...mapState({
            products: state => state.store,
            trainers: state => state.trainers,
            token: state => state.token
        }),
        safeProducts() {
    return Array.isArray(this.products) ? this.products.slice(0, 4) : [];
  },
        isLoggedIn() {
      return this.token !== null;
    }
    },
    methods: {

        ...mapActions(['AllProducts', 'AllTrainers', 'logoutUser']),

        openModal(trainer) {
            this.selectedTrainer = trainer;
            this.isModalVisible = true;
        },
        closeModal() {
            this.selectedTrainer = null;
            this.isModalVisible = false;
        },
        Login() {
            this.$router.push("/login");
        },
        logout() {
      this.logoutUser();
      localStorage.removeItem('activeForm');  // Clear saved form state to reset login view
      this.$router.push("/");
    },
        goToPlans() {
    if (this.isLoggedIn) {
      this.$router.push("/plans");
    } else {
      this.$router.push("/login");
    }
  },
        toggleMenu() {
            this.isMenuOpen = !this.isMenuOpen;
        }
    },
    mounted() {
        this.AllProducts();
        this.AllTrainers();
        this.isLoading = false;
    }
};
</script>

<style scoped>
#body {
    font-family: 'Poppins', Arial, sans-serif;
    background-color: #333;
    box-sizing: border-box;
    line-height: 1.6;
}

.title {
    display: flex;
    justify-content: center;
    align-items: center;
    color: white;
    font-size: 2.5rem;
    margin: 2rem 0;
    text-align: center;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1px;
}


header {
    background-color: #333;
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

.container {
    width: 100%;
    max-width: 1400px;
    margin: 0 auto;
    padding: 0 20px;
}

.hero {
    width: 100%;
    height: 100vh;
    min-height: 600px;
    background-image: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), url("../assets/images/Displays/home-hero.jpg");
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    background-attachment: fixed;
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: left;
    color: white;
    text-align: left;
    position: relative;
}

.hero .hero-text {
    max-width: 50%;
    margin-left: 5%;
    text-align: left;
    animation: fadeInUp 1s ease;
}

@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }

    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.hero h1 {
    font-size: 3.5rem;
    margin-bottom: 1.5rem;
    line-height: 1.2;
    font-weight: 800;
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
}

.hero p {
    font-size: 1.5rem;
    margin-bottom: 2rem;
    text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
}

.hero button {
    padding: 15px 30px;
    font-size: 1.2rem;
    background-color: crimson;
    color: white;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: all 0.3s ease;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 1px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
}

.hero button:hover {
    background-color: #ff4d6d;
    transform: translateY(-3px);
    box-shadow: 0 6px 15px rgba(220, 20, 60, 0.4);
}

.hero button:active {
    transform: translateY(-1px);
}

.categories {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 30px;
    padding: 40px 20px;
}

.category {
    position: relative;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
    transition: all 0.4s ease;
    height: 300px;
}

.category:hover {
    transform: translateY(-10px);
    box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
}

.category img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.5s ease;
}

.category:hover img {
    transform: scale(1.05);
}

.category h3 {
    position: absolute;
    bottom: 0;
    left: 0;
    width: 100%;
    padding: 20px;
    margin: 0;
    color: white;
    background: linear-gradient(transparent, rgba(0, 0, 0, 0.8));
    font-size: 1.5rem;
    font-weight: 700;
    text-align: center;
}

.featured-products {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 30px;
    padding: 20px;
    margin-bottom: 50px;
}

.product {
    background: #444;
    border-radius: 10px;
    overflow: hidden;
    transition: all 0.3s ease;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    display: flex;
    flex-direction: column;
}

.product:hover {
    transform: translateY(-10px);
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
}

.product img {
    width: 100%;
    height: 250px;
    object-fit: cover;
    border-bottom: 3px solid crimson;
}

.product h2 {
    color: white;
    font-size: 1.3rem;
    margin: 15px 15px 5px;
    font-weight: 600;
}

.product p {
    color: #ddd;
    font-size: 1.1rem;
    margin: 0 15px 15px;
    font-weight: 700;
}

.product button {
    padding: 12px;
    margin: 0 15px 15px;
    background-color: crimson;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-weight: 600;
    transition: all 0.3s ease;
}

.product button:hover {
    background-color: #ff4d6d;
}

.wrapper {
    max-width: 1200px;
    margin: 50px auto;
    padding: 0 20px;
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 30px;
}

.card {
    position: relative;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    transition: all 0.3s ease;
    aspect-ratio: 1/1;
}

.card:hover {
    transform: scale(1.03);
    box-shadow: 0 10px 25px rgba(220, 20, 60, 0.3);
}

.card img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.overlay {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
    display: flex;
    justify-content: center;
    align-items: center;
    opacity: 0;
    transition: opacity 0.3s ease;
}

.card:hover .overlay {
    opacity: 1;
}

.view-btn {
    padding: 12px 25px;
    background-color: transparent;
    color: white;
    border: 2px solid white;
    font-weight: bold;
    cursor: pointer;
    border-radius: 30px;
    transition: all 0.3s ease;
    text-transform: uppercase;
    letter-spacing: 1px;
}

.view-btn:hover {
    background-color: crimson;
    border-color: crimson;
    transform: translateY(-3px);
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

/* Responsive styles */
@media (max-width: 1024px) {
    .hero .hero-text {
        max-width: 60%;
    }

    .hero h1 {
        font-size: 3rem;
    }

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

    .hero {
        height: 70vh;
        min-height: 500px;
        border-radius: 8px;
        background-attachment: scroll;
    }

    .hero .hero-text {
        max-width: 90%;
        margin: 0 auto;
        text-align: center;
    }

    .hero h1 {
        font-size: 2.5rem;
    }

    .login-btn {
        display: none;
    }

    .mobile-login {
        display: block;
    }

    .hero p {
        font-size: 1.2rem;
    }

    .categories {
        grid-template-columns: 1fr 1fr;
    }
}

@media (max-width: 480px) {
    .brand-name {
        font-size: 1.8rem;
    }

    .hero {
        border-radius: 8px;
    }

    .hero h1 {
        font-size: 2rem;
    }

    .hero p {
        font-size: 1rem;
    }

    .hero button {
        padding: 12px 25px;
        font-size: 1rem;
    }
    
    .title {
    font-size: 1.3rem;
    }
    
    .categories,
    .product,
    .card
    {
        grid-template-columns: 1fr;
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

.loading {
    display: inline-block;
    width: 40px;
    height: 40px;
    border: 4px solid rgba(255, 255, 255, 0.3);
    border-radius: 50%;
    border-top-color: crimson;
    animation: spin 1s ease-in-out infinite;
    margin: 20px auto;
}
</style>
