import { createApp } from "vue";
import App from "./App.vue";
import store from "./store/index.js";
import router from "./router/index.js";
import '@fortawesome/fontawesome-free/css/all.min.css';


createApp(App).use(store).use(router).mount("#app");
