Vue.component('alert-box', {
  props: ['errors'],
  template:`
      <div class="alert-box">
        <div class="alert alert-danger" v-for="error in errors">
          {{ error }} <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span>
        </div>
      </div>
  `
}); 

let ProviderLoginPage = {
  template:`
    <div id="vue-login-main">  
      <div id="login">
        <alert-box v-bind:errors="errors"></alert-box>
        <div id="login-form">
          <h1>LOGIN</h1>
          <div class="login-box">
            <label for="email">Email:</label>
            <input id="email" required type="email" class="form-control" v-model="email">
          </div>
          <div class="login-box">
            <label for="password">Password:</label>
            <input id="password" type="password" class="form-control" v-model="password">
          </div>
          <div class="login-box">
            <input id="login-btn" class="btn form-btn" type="submit" @click="submit()" name="Submit">
          </div>
        </div>
      </div>
    </div>
  `,
  data: function() {
    return {
      email: "",
      password: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      let params = {
        email: this.email, 
        password: this.password
      };

      if (this.errors.length >= 1) {
        this.errors = [];
      }

      if (this.email === '') {
        this.errors.push("Email required");
      }

      if (this.password === '') {
        this.errors.push("Password required");
      }
      
      if (this.errors.length === 0) {
        axios
          .post("/provider_login", params)
          .then(function(response) {
            if (response.data.jwt) {
              axios.defaults.headers.common["Authorization"] = "Bearer " + response.data.jwt;
              localStorage.setItem("jwt", response.data.jwt);
              localStorage.setItem("providerId", response.data.provider_id);
              router.push("/provider_login");
            } else {
              this.giveErrors();
            }
          })
          .catch(
            function(error) {
              this.errors = ['Incorrect email or password'];
              this.email = "";
              this.password = "";
            }.bind(this)
          );
      } 
    },
    giveErrors: function() {
      if (!localStorage.getItem("jwt")) {
        this.errors = ['Incorrect email or password'];
        this.email = "";
        this.password = "";
      }
    } 
  }
};

var ProviderLogoutPage = {
  template: "<h1>Logout</h1>",
  created: function() {
    axios.defaults.headers.common["Authorization"] = undefined;
    localStorage.removeItem("jwt");
    axios.delete('/provider_logout');
    router.push("/");
  }
};

let router = new VueRouter({
  routes: [ 
    { path: "/provider_login", component: ProviderLoginPage },
    { path: "/provider_logout", component: ProviderLogoutPage },
  ], 
  scrollBehavior: function(to, from, savedPosition) {
    return { x: 0, y: 0 };
  }
});

let app = new Vue({
  el: "#vue-app",
  router: router,
  created: function() {
    let jwt = localStorage.getItem("jwt");
    console.log('jwt');
    console.log(jwt);
    if (jwt) {
      axios.defaults.headers.common["Authorization"] = jwt;
    }
  }
});