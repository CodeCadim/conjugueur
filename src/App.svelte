<script>
  import { onMount } from 'svelte';
  import conjuguaisonData from './conjuguaison.json';
  
  let searchTerm = '';
  let conjugations = [];
  let selectedVerb = null;
  let filteredVerbs = [];
  
  onMount(() => {
    conjugations = conjuguaisonData;
  });
  
  $: {
    if (searchTerm.length > 1) {
      filteredVerbs = conjugations
        .filter(verb => verb.infinitif.toLowerCase().includes(searchTerm.toLowerCase()))
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
  
  const pronouns = ['je', 'tu', 'il/elle', 'nous', 'vous', 'ils/elles'];
  
  const tenses = [
    { key: 'present', title: 'Présent' },
    { key: 'imparfait', title: 'Imparfait' },
    { key: 'passeSimple', title: 'Passé simple' },
    { key: 'futurSimple', title: 'Futur simple' },
    { key: 'passeCompose', title: 'Passé composé' },
    { key: 'plusQueParfait', title: 'Plus-que-parfait' }
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
        <p><strong>Participe présent:</strong> {selectedVerb.participePresent}</p>
        <p><strong>Participe passé:</strong> {selectedVerb.participePasse}</p>
        <p><strong>Auxiliaire:</strong> {selectedVerb.auxiliaire}</p>
        {#if selectedVerb.formePronominale}
          <p><strong>Forme pronominale:</strong> {selectedVerb.formePronominale}</p>
        {/if}
      </div>
      
      {#each tenses as tense}
        {#if selectedVerb[tense.key]}
          <div class="tense-section">
            <h3 class="tense-title">{tense.title}</h3>
            <div class="conjugation-grid">
              {#each selectedVerb[tense.key] as form, index}
                <div class="pronoun-form">
                  <span class="pronoun">{pronouns[index]}</span>
                  <span class="form">{form}</span>
                </div>
              {/each}
            </div>
          </div>
        {/if}
      {/each}
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
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
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
</style>