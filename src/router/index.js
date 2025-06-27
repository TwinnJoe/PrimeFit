import { createRouter, createWebHistory } from 'vue-router';
import Home from '../views/Home.vue';
import Login from '../views/Login.vue';
import Cart from '../views/Cart.vue';
import Shop from '../views/Shop.vue';
import Payment from '../views/Payment.vue';
import Plans from '../views/Plans.vue';
import Products from '../views/Products.vue';
import TrainerDetails from '../components/TrainerDetails.vue';

const routes = [
  { path: '/',
    name:Home, 
    component: Home
   },
  { path: '/login', 
    name:Login,
    component: Login 
  },
  { path: '/shop', 
    name:Shop,
    component: Shop 
  },
  { path: '/cart', 
    name:Cart,
    component: Cart 
  },
  { path: '/payment', 
    name:Payment,
    component: Payment 
  },
  { path: '/plans', 
    name:Plans,
    component: Plans 
  },
  { path: '/products', 
    name:Products,
    component: Products 
  },
  { path: '/trainerdetails', 
    name: TrainerDetails,
    component: TrainerDetails 
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

export default router;