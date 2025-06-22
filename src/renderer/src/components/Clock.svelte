<script lang="ts">
  import dayjs from "dayjs";
  import { onMount } from "svelte";

  let current_time = dayjs().format("hh:mm A");

  onMount((): (() => void) => {
    const interval = setInterval(() => {
      current_time = dayjs().format("hh:mm A");
    }, 1000);

    return () => clearInterval(interval);
  });
</script>

<p>{current_time}</p>
