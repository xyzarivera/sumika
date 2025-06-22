<script lang="ts">
  import dayjs from "dayjs";
  import { onMount } from "svelte";

  const TIME_FORMAT = "hh:mm A";
  const DATE_FORMAT = "MMM DD YYYY, ddd";

  let currentDateTime = $state(new Date());

  let displayedTime = $derived(dayjs(currentDateTime).format(TIME_FORMAT));
  let displayedDate = $derived(dayjs(currentDateTime).format(DATE_FORMAT));

  onMount(() => {
    const interval = setInterval(() => {
      currentDateTime = new Date();
    }, 1000);

    return (): void => clearInterval(interval);
  });
</script>

<section class="text-center">
  <h1 hidden>datetime today</h1>
  <p class="text-8xl font-bold">{displayedTime}</p>
  <p class="text-2xl font-semibold">{displayedDate}</p>
</section>
