<script lang="ts">
  import dayjs from "dayjs";
  import { onMount } from "svelte";

  let current_time = dayjs().format("hh:mm A");
  let current_date = dayjs().format("MMM DD YYYY, ddd");

  onMount((): (() => void) => {
    const interval = setInterval(() => {
      current_time = dayjs().format("hh:mm A");
      current_date = dayjs().format("MMM DD YYYY, ddd");
    }, 1000);

    return () => clearInterval(interval);
  });
</script>

<section class="text-center">
  <h1 hidden>datetime today</h1>
  <p class="text-[120px] font-bold">{current_time}</p>
  <p class="text-2xl font-semibold">{current_date}</p>
</section>
