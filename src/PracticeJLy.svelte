<script lang="ts">
    import { createEventDispatcher, onMount } from "svelte";
    import dictionary from "./data/j-ly.txt?raw";
    import { pickOne } from "./model";

    const dispatch = createEventDispatcher();
    const words = dictionary.split("\n");
    let word = "";
    let question = "";
    let correctAnswer = "";
    let options: string[] = [];

    onMount(next);

    function next() {
        word = pickOne(words);
        question = word.replace(
            /(.*?)(j|ly|J|Ly)(.*)/,
            (_, begin, removedLetter, end) => {
                correctAnswer = removedLetter;
                return `${begin}_${end}`;
            },
        );
        options = [correctAnswer, oppositeOf(correctAnswer)].toSorted();
    }

    function oppositeOf(correctAnswer: string): string {
        switch (correctAnswer) {
            case "j":
                return "ly";
            case "J":
                return "Ly";
            case "ly":
                return "j";
            case "Ly":
                return "J";
            default:
                return "";
        }
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
        {#each options as option}
            <button on:click={() => evaluate(option)}>{option}</button>
        {/each}
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
