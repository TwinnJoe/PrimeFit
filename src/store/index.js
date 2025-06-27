import { createStore } from "vuex";
import axios from "axios";
const API = import.meta.env.VITE_API_URL;

export default createStore({
  state: {
    users: null,
    store: null,
    trainers: null,
    plans: null,
    token: localStorage.getItem("token") || null,
  },
  getters: {
    allUsers: (state) => state.users,
    allStore:(state) => state.store,
    allTrainers:(state) => state.trainers,
    allPlans:(state) => state.plans,
  },
  mutations: {
    setUser:(state, users) => (state.users = users),
    setStore:(state, store) => (state.store = store),
    setTrainers:(state, trainers) => (state.trainers = trainers),
    setPlans:(state, plans) => (state.plans = plans),
    setToken:(state, token) => (state.token = token),
  },
  actions: {
    async AllProducts({ commit }) {
      try {
        const res = await fetch(`${API}/api/store`);
        if (!res.ok) throw new Error("Failed to fetch Products");
        commit("setStore", await res.json());
      } catch (error) {
        console.error("Error fetching products:", error);
      }
    },

    async AllTrainers({ commit }) {
      try {
        const res = await fetch(`${API}/api/trainers`);
        if (!res.ok) throw new Error("Failed to fetch Trainers");
        commit("setTrainers", await res.json());
      } catch (error) {
        console.error("Error fetching Trainers:", error);
      }
    },

    async AllPlans({ commit }) {
      try {
        const res = await fetch(`${API}/api/plans`);
        if (!res.ok) throw new Error("Failed to fetch Plans");
        commit("setPlans", await res.json());
      } catch (error) {
        console.error("Error fetching Plans:", error);
      }
    },
    async addUsers({ dispatch }, payload) {
      try {
        await fetch(`${API}/api/users/register`, {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(payload),
        });
      } catch (error) {
        console.error("Error adding User:", error);
      }
    },
    async updateUser({ commit, dispatch }, payload) {
    try {
      const res = await fetch(`${API}/api/users/profile`, {
        method: "PUT",
        headers: {
          "Content-Type": "application/json"
        },
        body: JSON.stringify(payload)
      });

      if (!res.ok) {
        const errorData = await res.json();
        throw new Error(errorData.message || "Failed to update profile");
      }


    } catch (error) {
      console.error("Error updating user profile:", error);
      throw error;
    }
  },
    async loginUser({ commit }, credentials) {
      try {
        const res = await axios.post(`${API}/api/users/login`, credentials);
        const { token, user } = res.data;
        localStorage.setItem("token", token);
        commit("setToken", token);
        commit("setUser", user);
      } catch (error) {
        console.error("Error logging in", error);
        throw new Error("Invalid credentials");
      }
    },

    logoutUser({ commit }) {
      localStorage.removeItem("token");
      commit("setToken", null);
      commit("setUser", null);
    }
  },
  modules: {},
});
