<script lang="ts">
  import type { Result } from "./model";

  export let resultLog: Result[] = [];
</script>

<pre>
{#each resultLog as rl}{rl.correct ? "✅" : "❌"} {rl.message}<br />{/each}
</pre>
