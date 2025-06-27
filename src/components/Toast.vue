<!-- src/components/Toast.vue -->
<template>
  <div v-if="visible" class="toast" :class="type" @click="hideToast">
    <p>{{ message }}</p>
  </div>
</template>

<script>
export default {
  name: "ToastView",
  data() {
    return {
      visible: false,
      message: '',
      type: 'success', // default type
    };
  },
  methods: {
    showToast(message, type = 'success') {
      this.message = message;
      this.type = type;
      this.visible = true;

      setTimeout(() => {
        this.visible = false;
      }, 3000); // Hide after 3 seconds
    },
    hideToast() {
      this.visible = false;
    },
  },
};
</script>

<style scoped>
.toast {
  position: fixed;
  top: 20px;
  left: 50%;
  transform: translateX(-50%);
  padding: 15px 25px;
  border-radius: 8px;
  color: white;
  z-index: 1000;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
  display: flex;
  align-items: center;
  justify-content: center;
  min-width: 250px;
  max-width: 90%;
  text-align: center;
  cursor: pointer;
  animation: slideIn 0.3s ease-out forwards;
  transition: all 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55);
  opacity: 0;
  border-left: 5px solid rgba(255, 255, 255, 0.3);
}

.toast.success {
  background-color: #4caf50;
}

.toast.error {
  background-color: crimson;
}

.toast p {
  margin: 0;
  font-size: 0.95rem;
  font-weight: 500;
  letter-spacing: 0.3px;
}

/* Animations */
@keyframes slideIn {
  from {
    opacity: 0;
    transform: translateX(-50%) translateY(-30px);
  }
  to {
    opacity: 1;
    transform: translateX(-50%) translateY(0);
  }
}

.toast-leave-active {
  animation: slideOut 0.3s ease-in forwards;
}

@keyframes slideOut {
  from {
    opacity: 1;
    transform: translateX(-50%) translateY(0);
  }
  to {
    opacity: 0;
    transform: translateX(-50%) translateY(-30px);
  }
}

/* Hover effects */
.toast:hover {
  transform: translateX(-50%) scale(1.02);
  box-shadow: 0 6px 16px rgba(0, 0, 0, 0.2);
}

.toast:active {
  transform: translateX(-50%) scale(0.98);
}

/* Responsive adjustments */
@media (max-width: 480px) {
  .toast {
    width: 90%;
    padding: 12px 20px;
    border-radius: 6px;
  }
  
  .toast p {
    font-size: 0.9rem;
  }
}
</style>