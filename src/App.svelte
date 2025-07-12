<script>
	import { onMount } from "svelte";

	let searchTerm = "";
	let verbsList = [];
	let selectedVerb = null;
	let activeMode = "Indicatif";
	let loading = false;
	let verbCache = new Map();

	onMount(async () => {
		try {
			const response = await fetch("./index.json");
			verbsList = await response.json();
		} catch (error) {
			console.error("Erreur lors du chargement de l'index:", error);
		}
	});

	async function loadVerb(infinitif) {
		if (!infinitif || infinitif.trim() === "") {
			selectedVerb = null;
			return;
		}

		// Vérifier si le verbe existe dans l'index
		if (!verbsList.includes(infinitif)) {
			selectedVerb = null;
			return;
		}

		// Vérifier le cache
		if (verbCache.has(infinitif)) {
			selectedVerb = verbCache.get(infinitif);
			return;
		}

		loading = true;
		try {
			const response = await fetch(`./verbs/${infinitif}.json`);
			if (response.ok) {
				const verb = await response.json();
				verbCache.set(infinitif, verb);
				selectedVerb = verb;
			} else {
				selectedVerb = null;
			}
		} catch (error) {
			console.error(`Erreur lors du chargement du verbe ${infinitif}:`, error);
			selectedVerb = null;
		} finally {
			loading = false;
		}
	}

	function handleInput() {
		loadVerb(searchTerm);
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
			list="verbs-list"
			bind:value={searchTerm}
			on:input={handleInput}
		/>
		<datalist id="verbs-list">
			{#each verbsList as verb}
				<option value={verb}></option>
			{/each}
		</datalist>
		
		{#if loading}
			<div class="loading">Chargement...</div>
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

	.loading {
		text-align: center;
		color: var(--text-accent);
		font-style: italic;
		margin-top: 10px;
		transition: color 0.3s ease;
	}

	h1 {
		color: var(--text-primary);
		text-align: center;
		margin-bottom: 30px;
		transition: color 0.3s ease;
	}

	h2 {
		margin: 0 0 15px 0;
		color: var(--text-accent);
		font-size: 24px;
		transition: color 0.3s ease;
	}

	.tabs {
		display: flex;
		border-bottom: 2px solid var(--border-light);
		margin-bottom: 20px;
		gap: 2px;
		transition: border-color 0.3s ease;
	}

	.tab {
		padding: 12px 20px;
		border: none;
		background: var(--bg-tertiary);
		color: var(--text-secondary);
		cursor: pointer;
		font-size: 14px;
		font-weight: 500;
		border-radius: 6px 6px 0 0;
		transition: all 0.3s ease;
		border-bottom: 2px solid transparent;
	}

	.tab:hover {
		background: var(--border-light);
		color: var(--text-accent);
	}

	.tab.active {
		background: var(--text-accent);
		color: white;
		border-bottom-color: var(--text-accent);
	}

	.mode-content {
		min-height: 200px;
	}

</style>

