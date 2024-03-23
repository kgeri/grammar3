<script lang="ts">
    import { createEventDispatcher, onMount } from "svelte";
    import { pickOne, type Result } from "./model";
    import dictionary from "./data/j-ly.txt?raw";

    const dispatch = createEventDispatcher();
    const words = dictionary.split("\n");
    let word = "";
    let question = "";

    onMount(next);

    function next() {
        word = pickOne(words);
        question = word.replace(/(j|ly)/, "_");
    }

    export function evaluate(letter: string) {
        const response = question.replace("_", letter);
        const result = {
            correct: response == word,
            message: `${response}`,
        };

        next();
        dispatch("result", result);
    }
</script>

<article>
    <h2>{question}</h2>
    <div role="group">
        <button on:click={() => evaluate("j")}>j</button>
        <button on:click={() => evaluate("ly")}>ly</button>
    </div>
</article>

<style>
    article {
        text-align: center;
    }

    button {
        margin: 0.5em;
    }
</style>
