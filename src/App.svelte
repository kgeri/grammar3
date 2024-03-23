<script lang="ts">
  import { link, Route, Router } from "svelte-routing";
  import PracticeJLy from "./PracticeJLy.svelte";

  export let url = "";
</script>

<main>
  <Router {url}>
    <nav>
      <a href="/" class="link" use:link>J vagy Ly</a>
    </nav>

    <Route path="/"><PracticeJLy /></Route>
  </Router>
</main>

<style>
  nav {
    font-size: small;
  }

  nav a + a:before {
    content: "|";
    padding: 0 0.2em;
  }
</style>
