<script lang="ts">
    import { createEventDispatcher, onMount } from "svelte";
    import spelling from "./data/spelling.txt?raw";
    import { pickOne } from "./model";
    import i18n from "./i18n";

    const dispatch = createEventDispatcher();
    const sentences = spelling.trim().split("\n");

    let audioElement: HTMLAudioElement;
    let responseInput: HTMLInputElement;
    let sentence = "";
    let response = "";

    onMount(next);

    function next() {
        sentence = pickOne(sentences);
        responseInput.focus();
        audioElement.play();
    }

    function evaluate() {
        const correct = response === sentence;
        const result = {
            correct: correct,
            message: correct ? response : `${response} (${sentence})`,
        };

        next();
        dispatch("result", result);
    }
</script>

<article>
    <form on:submit|preventDefault={evaluate}>
        <label for="response">
            <audio bind:this={audioElement} controls>
                <source src="spelling/{sentence}.mp3" />
            </audio>
        </label>
        <input id="response" bind:this={responseInput} type="text" bind:value={response} required />
        <input type="submit" value={i18n.submit} />
    </form>
</article>

<style>
    article {
        text-align: center;
    }
</style>
