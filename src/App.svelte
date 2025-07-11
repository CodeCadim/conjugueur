<script>
	import { onMount } from "svelte";

	let searchTerm = "";
	let conjugations = [];
	let selectedVerb = null;
	let filteredVerbs = [];
	let activeMode = "Indicatif";

	onMount(async () => {
		try {
			const response = await fetch("/conjuguaison.json");
			conjugations = await response.json();
		} catch (error) {
			console.error("Erreur lors du chargement des conjugaisons:", error);
		}
	});

	$: {
		if (searchTerm.length > 1) {
			filteredVerbs = conjugations
				.filter((verb) =>
					verb.infinitif
						.toLowerCase()
						.includes(searchTerm.toLowerCase()),
				)
				.slice(0, 10);
		} else {
			filteredVerbs = [];
			selectedVerb = null;
		}
	}

	function selectVerb(verb) {
		selectedVerb = verb;
		searchTerm = verb.infinitif;
		filteredVerbs = [];
	}

	const pronouns = ["je", "tu", "il/elle", "nous", "vous", "ils/elles"];
	const modes = ["Indicatif", "Subjonctif", "Conditionnel", "Impératif"];

	function setActiveMode(mode) {
		activeMode = mode;
	}

	const tenses = [
		{ key: "present", title: "Présent", mode: "Indicatif" },
		{ key: "imparfait", title: "Imparfait", mode: "Indicatif" },
		{ key: "passeSimple", title: "Passé simple", mode: "Indicatif" },
		{ key: "futurSimple", title: "Futur simple", mode: "Indicatif" },
		{ key: "passeCompose", title: "Passé composé", mode: "Indicatif" },
		{ key: "plusQueParfait", title: "Plus-que-parfait", mode: "Indicatif" },
		{ key: "passeAnterieur", title: "Passé antérieur", mode: "Indicatif" },
		{ key: "futurAnterieur", title: "Futur antérieur", mode: "Indicatif" },
		{ key: "subjonctifPresent", title: "Présent", mode: "Subjonctif" },
		{ key: "subjonctifImparfait", title: "Imparfait", mode: "Subjonctif" },
		{ key: "subjonctifPasse", title: "Passé", mode: "Subjonctif" },
		{
			key: "subjonctifPlusQueParfait",
			title: "Plus-que-parfait",
			mode: "Subjonctif",
		},
		{ key: "conditionnelPresent", title: "Présent", mode: "Conditionnel" },
		{ key: "conditionnelPasse", title: "Passé", mode: "Conditionnel" },
		{
			key: "conditionnelPasseII",
			title: "Passé 2ème forme",
			mode: "Conditionnel",
		},
		{ key: "imperatif", title: "Présent", mode: "Impératif" },
		{ key: "imperatifPasse", title: "Passé", mode: "Impératif" },
	];
</script>

<div class="container">
	<h1>Conjugueur de verbes français</h1>

	<div class="search-container">
		<input
			type="text"
			class="search-box"
			placeholder="Rechercher un verbe..."
			bind:value={searchTerm}
		/>

		{#if filteredVerbs.length > 0}
			<div class="suggestions">
				{#each filteredVerbs as verb}
					<button
						class="suggestion-item"
						on:click={() => selectVerb(verb)}
					>
						{verb.infinitif}
					</button>
				{/each}
			</div>
		{/if}
	</div>

	{#if selectedVerb}
		<div class="conjugation">
			<div class="verb-info">
				<h2>{selectedVerb.infinitif}</h2>
				<p>
					<strong>Participe présent:</strong>
					{selectedVerb.participePresent}
				</p>
				<p>
					<strong>Participe passé:</strong>
					{selectedVerb.participePasse}
				</p>
				<p><strong>Auxiliaire:</strong> {selectedVerb.auxiliaire}</p>
				{#if selectedVerb.formePronominale}
					<p>
						<strong>Forme pronominale:</strong>
						{selectedVerb.formePronominale}
					</p>
				{/if}
			</div>

			<div class="tabs">
				{#each modes as mode}
					<button
						class="tab {activeMode === mode ? 'active' : ''}"
						on:click={() => setActiveMode(mode)}
					>
						{mode}
					</button>
				{/each}
			</div>

			<div class="mode-content">
				<div class="tenses-grid">
					{#each tenses.filter((t) => t.mode === activeMode) as tense}
						{#if selectedVerb[tense.key]}
							<div class="tense-section">
								<h4 class="tense-title">{tense.title}</h4>
								<div class="conjugation-grid">
									<div class="column">
										{#each [0, 1, 2] as index}
											{#if selectedVerb[tense.key][index]}
												<div class="pronoun-form">
													<span class="pronoun">{pronouns[index]}</span>
													<span class="form">{selectedVerb[tense.key][index]}</span>
												</div>
											{/if}
										{/each}
									</div>
									<div class="column">
										{#each [3, 4, 5] as index}
											{#if selectedVerb[tense.key][index]}
												<div class="pronoun-form">
													<span class="pronoun">{pronouns[index]}</span>
													<span class="form">{selectedVerb[tense.key][index]}</span>
												</div>
											{/if}
										{/each}
									</div>
								</div>
							</div>
						{/if}
					{/each}
				</div>
			</div>
		</div>
	{/if}
</div>

<style>
	.search-container {
		position: relative;
		margin-bottom: 20px;
	}

	.suggestions {
		position: absolute;
		top: 100%;
		left: 0;
		right: 0;
		background: white;
		border: 1px solid #ddd;
		border-top: none;
		border-radius: 0 0 4px 4px;
		max-height: 200px;
		overflow-y: auto;
		z-index: 10;
		box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	}

	.suggestion-item {
		display: block;
		width: 100%;
		padding: 10px 15px;
		border: none;
		background: none;
		text-align: left;
		cursor: pointer;
		font-size: 14px;
	}

	.suggestion-item:hover {
		background-color: #f8f9fa;
	}

	h1 {
		color: #333;
		text-align: center;
		margin-bottom: 30px;
	}

	h2 {
		margin: 0 0 15px 0;
		color: #007bff;
		font-size: 24px;
	}

	.tabs {
		display: flex;
		border-bottom: 2px solid #e9ecef;
		margin-bottom: 20px;
		gap: 2px;
	}

	.tab {
		padding: 12px 20px;
		border: none;
		background: #f8f9fa;
		color: #495057;
		cursor: pointer;
		font-size: 14px;
		font-weight: 500;
		border-radius: 6px 6px 0 0;
		transition: all 0.2s ease;
		border-bottom: 2px solid transparent;
	}

	.tab:hover {
		background: #e9ecef;
		color: #007bff;
	}

	.tab.active {
		background: #007bff;
		color: white;
		border-bottom-color: #007bff;
	}

	.mode-content {
		min-height: 200px;
	}

</style>

