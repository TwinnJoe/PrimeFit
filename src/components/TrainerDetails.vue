<template>
  <div v-if="isVisible" class="modal-overlay" @click.self="closeModal">
    <div class="modal-content">
      <span class="close" @click="closeModal">&times;</span>
      <div class="trainer-image-container">
        <img :src="trainer.image_url" :alt="trainer.name" class="trainer-image" />
      </div>
      <h3>{{ trainer.name }}</h3>
      <p class="specialization">{{ trainer.specialization }}</p>
      <p><i class="fas fa-medal"></i> {{ trainer.experience }} Years Experience</p>
      <p><i class="fas fa-envelope"></i> Get in Contact: {{ trainer.email }}</p>
      <div class="social-icons">
        <a :href="trainer.instagram" target="_blank">
          <i class="fab fa-instagram"></i>
        </a>
        <a :href="trainer.facebook" target="_blank">
          <i class="fab fa-facebook"></i>
        </a>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "TrainerDetailsView",
  props: {
    trainer: Object,
    isVisible: Boolean,
  },
  methods: {
    closeModal() {
      this.$emit('close');
    },
    Tutorials() {
      this.$router.push('/trainers');
    },
  },
};
</script>

<style scoped>
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.8);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 2000;
  opacity: 0;
  transition: opacity 0.3s ease;
  backdrop-filter: blur(5px);
}

.modal-overlay {
  opacity: 1;
}

.modal-content {
  background: #333;
  padding: 40px;
  border-radius: 12px;
  color: white;
  text-align: center;
  max-width: 500px;
  width: 90%;
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
  position: relative;
  transform: translateY(-20px);
  transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.modal-overlay .modal-content {
  transform: translateY(0);
}

.trainer-image-container {
  margin: 0 auto 20px;
  width: 200px;
  height: 200px;
  border-radius: 50%;
  overflow: hidden;
  border: 4px solid crimson;
  box-shadow: 0 5px 15px rgba(220, 20, 60, 0.3);
  transition: transform 0.3s ease;
}

.trainer-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.5s ease;
}

.trainer-image-container:hover {
  transform: scale(1.05);
}

.trainer-image-container:hover .trainer-image {
  transform: scale(1.1);
}

.modal-content h3 {
  font-size: 2rem;
  color: white;
  margin-bottom: 10px;
  font-weight: 700;
  letter-spacing: 1px;
  text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.3);
}

.specialization {
  font-size: 1.1rem;
  color: #ddd;
  font-style: italic;
  margin-bottom: 25px;
  position: relative;
  padding-bottom: 15px;
}

.specialization::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 50%;
  transform: translateX(-50%);
  width: 50px;
  height: 2px;
  background: crimson;
}


.card p {
  margin: 0.8rem 0;
  color: #ddd;
  font-size: 0.95rem;
}

.card i {
  color: #ff4757;
  margin-right: 8px;
}

.social-icons {
  margin: 1.5rem 0;
  display: flex;
  justify-content: center;
  gap: 1.5rem;
}

.social-icons a {
  color: #bbb;
  font-size: 1.5rem;
  transition: all 0.3s ease;
}

.social-icons a:hover {
  color: #ff4757;
  transform: scale(1.2);
}

.close {
  cursor: pointer;
  font-size: 28px;
  position: absolute;
  top: 15px;
  right: 20px;
  color: white;
  transition: all 0.3s ease;
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.1);
}

.close:hover {
  color: crimson;
  transform: rotate(90deg);
  background: rgba(255, 255, 255, 0.2);
}

/* Responsive adjustments */
@media (max-width: 600px) {
  .modal-content {
    padding: 30px 20px;
  }

  .trainer-image-container {
    width: 150px;
    height: 150px;
  }

  .modal-content h3 {
    font-size: 1.5rem;
  }

  .specialization {
    font-size: 1rem;
  }

  .view-more-btn {
    padding: 10px 25px;
    font-size: 0.9rem;
  }
}
</style>