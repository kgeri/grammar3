<script lang="ts">
  import { link, Route, Router } from "svelte-routing";
  import i18n from "./i18n";
  import type { Result } from "./model";
  import PracticeJLy from "./PracticeJLy.svelte";
  import PracticeSpell from "./PracticeSpell.svelte";
  import ResultLog from "./ResultLog.svelte";
  import ResultRating from "./ResultRating.svelte";

  export let url = "";
  let resultLog: Result[] = [];

  function onResult(e: CustomEvent<Result>) {
    resultLog = [e.detail, ...resultLog];
  }
</script>

<nav>
  <a href="/" class="link" use:link>{i18n.types.jorly}</a>
  <a href="/spell" class="link" use:link>{i18n.types.spell}</a>
</nav>
<main>
  <Router {url}>
    <Route path="/"><PracticeJLy on:result={onResult} /></Route>
    <Route path="/spell"><PracticeSpell on:result={onResult} /></Route>
  </Router>
</main>
<footer>
  <ResultRating {resultLog} />
  <ResultLog {resultLog} />
</footer>

<style>
  nav {
    font-size: small;
    padding: 0.5em;
    justify-content: center;
  }

  nav a + a:before {
    content: "|";
    padding: 0 0.2em;
  }

  main {
    max-width: 600px;
  }

  footer {
    padding-top: 0px;
    max-width: 600px;
  }
</style>
