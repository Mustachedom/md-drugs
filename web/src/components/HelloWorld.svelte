<script lang="ts">
  import { visibility, employees, hireable, drugStocks, playerItems, jobRole } from '../store/stores';
  import { fetchNui } from '../utils/fetchNui';
  import { onMount } from 'svelte';

  // --- SUBSCRIBE TO STORES ---
  let cokeItems: any[] = [];
  let currentItems: any[] = [];
  let employeesList: any[] = [];
  let hireableList: any[] = [];

  // Sync store values to local reactive vars
  drugStocks.subscribe(value => {
    if (value) cokeItems = value;
  });

  playerItems.subscribe(value => {
    if (value) currentItems = value;
  });

  employees.subscribe(value => {
    if (value) employeesList = value;
  });

  hireable.subscribe(value => {
    if (value) hireableList = value;
  });

  // --- PAGE STATE ---
  let pages = ['cokeItems', 'employees', 'management'];
  let currentPage = 'cokeItems';
  let selectedItem = null;
  let editAmount = 0;
  let hiringFor: null | string = null;

  // --- UTIL FUNCTIONS ---
  function getEmployeeForRole(role: string) {
    return employeesList.find(emp => emp.role === role) || null;
  }

  function getHireableForRole(role: string) {
    return hireableList.filter(person => person.role === role);
  }

  // --- HIRE / FIRE (UPDATE STORES, NOT LOCAL VARS) ---
  function hireEmployee(person) {
    // Update the STORE, not local variable
    employees.update(prev => [...(prev || []), person]);
    hireable.update(prev => (prev || []).filter(p => p !== person));
    hiringFor = null;
    currentPage = 'employees'; // switch immediately, no timeout needed
  }

  function fireEmployee(person) {
    employees.update(prev => (prev || []).filter(emp => emp !== person));
    hireable.update(prev => [...(prev || []), person]);
    currentPage = 'employees';
  }

  // --- OTHER FUNCTIONS ---
  function switchPage(page: string) {
    currentPage = page;
    selectedItem = null;
  }

  function openItemDetail(itemKey: string) {
    const item = cokeItems.find(i => i.item === itemKey);
    const inv = currentItems.find(i => i.item === itemKey);
    if (!item || !inv) return;

    selectedItem = {
      ...item,
      inventoryAmount: inv.amount
    };
    editAmount = item.amount;
  }

  function saveAmount() {
    if (!selectedItem) return;
    const difference = editAmount - selectedItem.amount;
    console.log(`Saving ${difference > 0 ? 'added' : 'removed'} ${Math.abs(difference)} units`);
    
    // TODO: Here you should update drugStocks store if needed
    // For now, just close
    selectedItem = null;
  }

  function cancelEdit() {
    selectedItem = null;
  }

  // --- REACTIVE DERIVED VALUES ---
  $: stockDifference = selectedItem ? editAmount - selectedItem.amount : 0;
  $: isAddingStock = stockDifference > 0;
  $: isRemovingStock = stockDifference < 0;
</script>

<div class="app-container">
  <aside class="sidebar">
    <div class="logo">
      <div class="logo-icon">⚗</div>
      <h1>Lab Control</h1>
    </div>
    
    <nav class="nav-menu">
      <button 
        class="nav-item" 
        class:active={currentPage === 'cokeItems'}
        on:click={() => switchPage('cokeItems')}
        disabled={selectedItem !== null}
      >
        <span class="nav-icon">📦</span>
        <span class="nav-label">Inventory</span>
      </button>
      
      <button 
        class="nav-item" 
        class:active={currentPage === 'employees'}
        on:click={() => switchPage('employees')}
        disabled={selectedItem !== null}
      >
        <span class="nav-icon">👥</span>
        <span class="nav-label">Personnel</span>
      </button>
      
      <button 
        class="nav-item" 
        class:active={currentPage === 'management'}
        on:click={() => switchPage('management')}
        disabled={selectedItem !== null}
      >
        <span class="nav-icon">⚙️</span>
        <span class="nav-label">Operations</span>
      </button>
    </nav>
  </aside>

  <main class="main-content">
    {#if selectedItem}
      <div class="detail-view">
        <button class="back-button" on:click={cancelEdit}>
          ← Back to Inventory
        </button>
        
        <div class="detail-container">
          <div class="detail-left">
            <div class="item-preview">
              <img src={selectedItem.image} alt={selectedItem.label} />
            </div>
            <h2>{selectedItem.label}</h2>
            <p class="item-id">{selectedItem.item}</p>
          </div>
          
          <div class="detail-right">
            <div class="stats-container">
              <div class="stat-card">
                <span class="stat-label">Lab Stock</span>
                <span class="stat-value">{selectedItem.amount}</span>
              </div>
              <div class="stat-card">
                <span class="stat-label">Inventory</span>
                <span class="stat-value">{selectedItem.inventoryAmount}</span>
              </div>
              <div class="stat-card highlighted">
                <span class="stat-label">Total Available</span>
                <span class="stat-value">{selectedItem.amount + selectedItem.inventoryAmount}</span>
              </div>
            </div>

            <div class="form-group">
              <label>Adjust Lab Quantity</label>
              <div class="quantity-adjuster">
                <button class="qty-btn" on:click={() => editAmount = Math.max(0, editAmount - 1)}>−</button>
                <input
                  type="number"
                  min="0"
                  max={selectedItem.amount + selectedItem.inventoryAmount}
                  bind:value={editAmount}
                  class="input-field"
                />
                <button class="qty-btn" on:click={() => editAmount = Math.min(selectedItem.amount + selectedItem.inventoryAmount, editAmount + 1)}>+</button>
              </div>
              
              {#if stockDifference !== 0}
                <div class="stock-change-indicator" class:adding={isAddingStock} class:removing={isRemovingStock}>
                  {#if isAddingStock}
                    <span class="change-icon">↑</span>
                    <span>Adding {Math.abs(stockDifference)} units to lab stock</span>
                  {:else}
                    <span class="change-icon">↓</span>
                    <span>Removing {Math.abs(stockDifference)} units from lab stock</span>
                  {/if}
                </div>
              {/if}
            </div>

            <div class="button-group">
              {#if stockDifference !== 0}
                <button 
                  class="btn" 
                  class:btn-success={isAddingStock}
                  class:btn-danger={isRemovingStock}
                  on:click={saveAmount}
                >
                  {isAddingStock ? '+ Add Stock' : '− Remove Stock'}
                </button>
              {:else}
                <button class="btn btn-disabled" disabled>No Changes</button>
              {/if}
              <button class="btn btn-secondary" on:click={cancelEdit}>Cancel</button>
            </div>
          </div>
        </div>
      </div>

    {:else if currentPage === 'cokeItems'}
      <div class="page-header">
        <h2>Inventory Management</h2>
        <p>Click any item to view details and adjust quantities</p>
      </div>
      
      <div class="inventory-grid">
        {#each cokeItems as item}
          <div class="inventory-card" on:click={() => openItemDetail(item.item)}>
            <div class="card-image">
              <img src={item.image} alt={item.label} />
            </div>
            <div class="card-content">
              <h3>{item.label}</h3>
              <div class="quantity">
                <span class="quantity-value">{item.amount}</span>
                <span class="quantity-label">units</span>
              </div>
            </div>
          </div>
        {/each}
      </div>

    {:else if currentPage === 'employees'}
      <div class="page-header">
        <h2>Personnel Management</h2>
        <p>Manage your lab workforce and hire new talent</p>
      </div>

      {#if hiringFor}
        <div class="hiring-section">
          <button class="back-button" on:click={() => hiringFor = null}>
            ← Back to Roles
          </button>
          
          <h3>Available Candidates - {hiringFor}</h3>
          
          <div class="candidates-grid">
            {#each getHireableForRole(hiringFor) as candidate}
              <div class="candidate-card">
                <div class="candidate-info">
                  <div class="candidate-avatar">{candidate.name.charAt(0)}</div>
                  <div class="candidate-details">
                    <h4>{candidate.name}</h4>
                    <span class="role-badge">{candidate.role}</span>
                  </div>
                </div>
                
                <div class="candidate-stats">
                  <div class="stat-mini">
                    <span class="stat-mini-label">⚡ Speed</span>
                    <div class="stat-bar">
                      <div class="stat-fill stat-fill-speed" style="width: {candidate.Stats.speed * 10}%"></div>
                    </div>
                    <span class="stat-mini-value">{candidate.Stats.speed}/10</span>
                  </div>
                  <div class="stat-mini">
                    <span class="stat-mini-label">⭐ Quality</span>
                    <div class="stat-bar">
                      <div class="stat-fill stat-fill-quality" style="width: {candidate.Stats.quality * 10}%"></div>
                    </div>
                    <span class="stat-mini-value">{candidate.Stats.quality}/10</span>
                  </div>
                  <div class="stat-mini">
                    <span class="stat-mini-label">🎯 Consistency</span>
                    <div class="stat-bar">
                      <div class="stat-fill stat-fill-consistency" style="width: {candidate.Stats.consistency * 10}%"></div>
                    </div>
                    <span class="stat-mini-value">{candidate.Stats.consistency}/10</span>
                  </div>
                </div>
                
                <button class="btn btn-success btn-hire" on:click={() => hireEmployee(candidate)}>
                  <span class="btn-icon">✓</span>
                  Hire Candidate
                </button>
              </div>
            {:else}
              <p class="empty-state">No available candidates for this role</p>
            {/each}
          </div>
        </div>
      {:else}
        <div class="roles-grid">
          {#each jobRoles as role}
            <div class="role-card">
              <div class="role-title">
                <h3>{role}</h3>
              </div>
              
              {#if getEmployeeForRole(role)}
                <div class="employee-card">
                  <div class="employee-info">
                    <div class="employee-avatar">{getEmployeeForRole(role).name.charAt(0)}</div>
                    <div class="employee-details">
                      <h4>{getEmployeeForRole(role).name}</h4>
                      <span class="employee-role">{role}</span>
                    </div>
                  </div>
                  
                  <div class="employee-stats">
                    <div class="stat-mini">
                      <span class="stat-mini-label">⚡ Speed</span>
                      <div class="stat-bar">
                        <div class="stat-fill stat-fill-speed" style="width: {getEmployeeForRole(role).Stats.speed * 10}%"></div>
                      </div>
                      <span class="stat-mini-value">{getEmployeeForRole(role).Stats.speed}/10</span>
                    </div>
                    <div class="stat-mini">
                      <span class="stat-mini-label">⭐ Quality</span>
                      <div class="stat-bar">
                        <div class="stat-fill stat-fill-quality" style="width: {getEmployeeForRole(role).Stats.quality * 10}%"></div>
                      </div>
                      <span class="stat-mini-value">{getEmployeeForRole(role).Stats.quality}/10</span>
                    </div>
                    <div class="stat-mini">
                      <span class="stat-mini-label">🎯 Consistency</span>
                      <div class="stat-bar">
                        <div class="stat-fill stat-fill-consistency" style="width: {getEmployeeForRole(role).Stats.consistency * 10}%"></div>
                      </div>
                      <span class="stat-mini-value">{getEmployeeForRole(role).Stats.consistency}/10</span>
                    </div>
                  </div>
                  
                  <button class="btn btn-danger btn-fire" on:click={() => fireEmployee(getEmployeeForRole(role))}>
                    <span class="btn-icon">🗑️</span>
                    Terminate Employee
                  </button>
                </div>
              {:else}
                <div class="empty-role">
                  <p>No personnel assigned</p>
                  <button class="btn btn-outline" on:click={() => hiringFor = role}>
                    + Hire for this role
                  </button>
                </div>
              {/if}
            </div>
          {/each}
        </div>
      {/if}
    {/if}
  </main>
</div>

<style>
  * {
    box-sizing: border-box;
  }

  .app-container {
    position: absolute;
    top: 50%;
    left: 50%;
    width: 80%;
    height: 80%;
    transform: translate(-50%, -50%);
    background: linear-gradient(135deg, #0f0f0f 0%, #1a1a1a 100%);
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen', 'Ubuntu', sans-serif;
    color: #e0e0e0;
    border-radius: 16px;
    display: flex;
    overflow: hidden;
  }

  .sidebar {
    width: 20%;
    background: rgba(20, 20, 20, 0.95);
    border-right: 1px solid rgba(255, 255, 255, 0.1);
    display: flex;
    flex-direction: column;
  }

  .logo {
    padding: 32px 24px;
    border-bottom: 1px solid rgba(255, 255, 255, 0.08);
    display: flex;
    align-items: center;
    gap: 12px;
  }

  .logo-icon {
    font-size: 32px;
    filter: grayscale(1) brightness(1.2);
  }

  .logo h1 {
    font-size: 20px;
    font-weight: 600;
    color: #ffffff;
    letter-spacing: -0.5px;
  }

  .nav-menu {
    padding: 24px 16px;
    display: flex;
    flex-direction: column;
    gap: 8px;
  }

  .nav-item {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 14px 16px;
    background: transparent;
    border: none;
    border-radius: 10px;
    color: #999;
    font-size: 15px;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s ease;
    text-align: left;
  }

  .nav-item:hover:not(:disabled) {
    background: rgba(255, 255, 255, 0.05);
    color: #e0e0e0;
  }

  .nav-item.active {
    background: rgba(255, 255, 255, 0.12);
    color: #ffffff;
  }

  .nav-item:disabled {
    opacity: 0.4;
    cursor: not-allowed;
  }

  .nav-icon {
    font-size: 20px;
    filter: grayscale(1);
  }

  .main-content {
    flex: 1;
    overflow-y: auto;
    padding: 32px 40px;
  }

  .main-content::-webkit-scrollbar {
    display: none;
  }

  .page-header {
    margin-bottom: 32px;
  }

  .page-header h2 {
    font-size: 28px;
    font-weight: 600;
    margin-bottom: 8px;
    color: #ffffff;
  }

  .page-header p {
    font-size: 15px;
    color: #888;
  }

  .inventory-grid {
    display: grid;
    grid-template-columns: repeat(6, 1fr);
    gap: 20px;
  }

  .inventory-card {
    background: rgba(30, 30, 30, 0.6);
    border: 1px solid rgba(255, 255, 255, 0.1);
    border-radius: 12px;
    padding: 20px;
    cursor: pointer;
    transition: all 0.3s ease;
  }

  .inventory-card:hover {
    background: rgba(40, 40, 40, 0.8);
    border-color: rgba(255, 255, 255, 0.2);
    transform: translateY(-4px);
    box-shadow: 0 12px 24px rgba(0, 0, 0, 0.4);
  }

  .card-image {
    width: 100%;
    height: 120px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: rgba(0, 0, 0, 0.3);
    border-radius: 8px;
    margin-bottom: 16px;
  }

  .card-image img {
    max-width: 90%;
    max-height: 90%;
    object-fit: contain;
  }

  .card-content h3 {
    font-size: 15px;
    font-weight: 600;
    color: #e0e0e0;
    margin-bottom: 8px;
  }

  .quantity {
    display: flex;
    align-items: baseline;
    gap: 6px;
  }

  .quantity-value {
    font-size: 24px;
    font-weight: 700;
    color: #ffffff;
  }

  .quantity-label {
    font-size: 13px;
    color: #666;
  }

  .detail-view {
    max-width: 1000px;
  }

  .back-button {
    padding: 10px 20px;
    background: rgba(255, 255, 255, 0.05);
    border: 1px solid rgba(255, 255, 255, 0.1);
    border-radius: 8px;
    color: #999;
    font-size: 14px;
    cursor: pointer;
    margin-bottom: 24px;
    transition: all 0.2s ease;
  }

  .back-button:hover {
    background: rgba(255, 255, 255, 0.08);
    color: #e0e0e0;
  }

  .detail-container {
    display: grid;
    grid-template-columns: 300px 1fr;
    gap: 40px;
    background: rgba(30, 30, 30, 0.6);
    border: 1px solid rgba(255, 255, 255, 0.1);
    border-radius: 16px;
    padding: 32px;
  }

  .detail-left {
    text-align: center;
  }

  .item-preview {
    width: 100%;
    height: 200px;
    background: rgba(0, 0, 0, 0.3);
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 20px;
  }

  .item-preview img {
    max-width: 90%;
    max-height: 90%;
    object-fit: contain;
  }

  .detail-left h2 {
    font-size: 22px;
    font-weight: 600;
    color: #ffffff;
    margin-bottom: 8px;
  }

  .item-id {
    font-size: 13px;
    color: #666;
    font-family: 'Courier New', monospace;
  }

  .detail-right {
    display: flex;
    flex-direction: column;
    gap: 24px;
  }

  .stats-container {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 16px;
  }

  .stat-card {
    background: rgba(0, 0, 0, 0.3);
    border: 1px solid rgba(255, 255, 255, 0.08);
    border-radius: 10px;
    padding: 20px;
    text-align: center;
  }

  .stat-card.highlighted {
    background: rgba(255, 255, 255, 0.08);
    border-color: rgba(255, 255, 255, 0.2);
  }

  .stat-label {
    display: block;
    font-size: 12px;
    color: #888;
    text-transform: uppercase;
    letter-spacing: 1px;
    margin-bottom: 8px;
  }

  .stat-value {
    display: block;
    font-size: 32px;
    font-weight: 700;
    color: #ffffff;
  }

  .form-group {
    display: flex;
    flex-direction: column;
    gap: 8px;
  }

  .form-group label {
    font-size: 14px;
    font-weight: 500;
    color: #999;
  }

  .quantity-adjuster {
    display: flex;
    gap: 12px;
    align-items: center;
  }

  .qty-btn {
    width: 48px;
    height: 48px;
    background: rgba(255, 255, 255, 0.08);
    border: 1px solid rgba(255, 255, 255, 0.15);
    border-radius: 8px;
    color: #e0e0e0;
    font-size: 24px;
    font-weight: 300;
    cursor: pointer;
    transition: all 0.2s ease;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .qty-btn:hover {
    background: rgba(255, 255, 255, 0.15);
    border-color: rgba(255, 255, 255, 0.3);
    transform: scale(1.05);
  }

  .qty-btn:active {
    transform: scale(0.95);
  }

  .input-field {
    padding: 14px 16px;
    background: rgba(0, 0, 0, 0.3);
    border: 1px solid rgba(255, 255, 255, 0.1);
    border-radius: 8px;
    color: #ffffff;
    font-size: 16px;
    font-family: inherit;
    transition: all 0.2s ease;
    text-align: center;
    font-weight: 600;
    flex: 1;
  }

  .input-field:focus {
    outline: none;
    border-color: rgba(255, 255, 255, 0.3);
    background: rgba(0, 0, 0, 0.4);
  }

  .stock-change-indicator {
    padding: 12px 16px;
    border-radius: 8px;
    font-size: 14px;
    font-weight: 500;
    display: flex;
    align-items: center;
    gap: 8px;
    margin-top: 8px;
    animation: slideIn 0.3s ease;
  }

  @keyframes slideIn {
    from {
      opacity: 0;
      transform: translateY(-10px);
    }
    to {
      opacity: 1;
      transform: translateY(0);
    }
  }

  .stock-change-indicator.adding {
    background: rgba(45, 90, 45, 0.3);
    border: 1px solid rgba(80, 160, 80, 0.4);
    color: #8fd98f;
  }

  .stock-change-indicator.removing {
    background: rgba(90, 45, 45, 0.3);
    border: 1px solid rgba(160, 80, 80, 0.4);
    color: #f99;
  }

  .change-icon {
    font-size: 18px;
    font-weight: bold;
  }

  .button-group {
    display: flex;
    gap: 12px;
    margin-top: auto;
  }

  .btn {
    flex: 1;
    padding: 14px 24px;
    border: none;
    border-radius: 10px;
    font-size: 15px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.2s ease;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
  }

  .btn:active {
    transform: scale(0.98);
  }

  .btn-icon {
    font-size: 16px;
  }

  .btn-disabled {
    background: rgba(255, 255, 255, 0.03);
    color: #555;
    cursor: not-allowed;
  }

  .btn-secondary {
    background: rgba(255, 255, 255, 0.05);
    color: #999;
    border: 1px solid rgba(255, 255, 255, 0.1);
  }

  .btn-secondary:hover {
    background: rgba(255, 255, 255, 0.08);
    color: #e0e0e0;
  }

  .btn-success {
    background: linear-gradient(135deg, #2d5a2d 0%, #1f4d1f 100%);
    color: #ffffff;
    box-shadow: 0 4px 12px rgba(45, 90, 45, 0.3);
  }

  .btn-success:hover {
    background: linear-gradient(135deg, #356535 0%, #275827 100%);
    transform: translateY(-2px);
    box-shadow: 0 6px 16px rgba(45, 90, 45, 0.5);
  }

  .btn-danger {
    background: linear-gradient(135deg, #5a2d2d 0%, #4d1f1f 100%);
    color: #ffffff;
    box-shadow: 0 4px 12px rgba(90, 45, 45, 0.3);
  }

  .btn-danger:hover {
    background: linear-gradient(135deg, #653535 0%, #582727 100%);
    transform: translateY(-2px);
    box-shadow: 0 6px 16px rgba(90, 45, 45, 0.5);
  }

  .btn-outline {
    background: transparent;
    color: #999;
    border: 2px dashed rgba(255, 255, 255, 0.2);
  }

  .btn-outline:hover {
    background: rgba(255, 255, 255, 0.05);
    border-style: solid;
    color: #e0e0e0;
  }

  .roles-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
    gap: 24px;
  }

  .role-card {
    background: rgba(30, 30, 30, 0.6);
    border: 1px solid rgba(255, 255, 255, 0.1);
    border-radius: 12px;
    padding: 24px;
    transition: all 0.3s ease;
  }

  .role-card:hover {
    border-color: rgba(255, 255, 255, 0.2);
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.3);
  }

  .role-title {
    margin-bottom: 20px;
    padding-bottom: 16px;
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
  }

  .role-title h3 {
    font-size: 18px;
    font-weight: 600;
    color: #e0e0e0;
  }

  .employee-card,
  .candidate-card {
    display: flex;
    flex-direction: column;
    gap: 16px;
    animation: fadeIn 0.3s ease;
  }

  @keyframes fadeIn {
    from {
      opacity: 0;
      transform: translateY(10px);
    }
    to {
      opacity: 1;
      transform: translateY(0);
    }
  }

  .employee-info,
  .candidate-info {
    display: flex;
    align-items: center;
    gap: 16px;
  }

  .employee-avatar,
  .candidate-avatar {
    width: 56px;
    height: 56px;
    background: linear-gradient(135deg, #505050 0%, #3a3a3a 100%);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 24px;
    font-weight: 600;
    color: #ffffff;
    border: 2px solid rgba(255, 255, 255, 0.15);
  }

  .employee-details,
  .candidate-details {
    flex: 1;
  }

  .employee-details h4,
  .candidate-details h4 {
    font-size: 16px;
    font-weight: 600;
    color: #ffffff;
    margin: 0;
  }

  .employee-role {
    font-size: 13px;
    color: #888;
    display: block;
    margin-top: 4px;
  }

  .role-badge {
    padding: 4px 12px;
    background: rgba(255, 255, 255, 0.1);
    border-radius: 12px;
    font-size: 12px;
    color: #999;
  }

  .employee-stats,
  .candidate-stats {
    display: flex;
    flex-direction: column;
    gap: 12px;
  }

  .stat-mini {
    display: flex;
    align-items: center;
    gap: 12px;
  }

  .stat-mini-label {
    font-size: 13px;
    color: #aaa;
    min-width: 120px;
    font-weight: 500;
  }

  .stat-bar {
    flex: 1;
    height: 10px;
    background: rgba(0, 0, 0, 0.4);
    border-radius: 5px;
    overflow: hidden;
    border: 1px solid rgba(255, 255, 255, 0.05);
  }

  .stat-fill {
    height: 100%;
    border-radius: 5px;
    transition: width 0.5s ease;
    position: relative;
    overflow: hidden;
  }

  .stat-fill::after {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
    animation: shimmer 2s infinite;
  }

  @keyframes shimmer {
    0% { transform: translateX(-100%); }
    100% { transform: translateX(100%); }
  }

  .stat-fill-speed {
    background: linear-gradient(90deg, #4a90e2 0%, #5ba3f5 100%);
  }

  .stat-fill-quality {
    background: linear-gradient(90deg, #e2a04a 0%, #f5b55b 100%);
  }

  .stat-fill-consistency {
    background: linear-gradient(90deg, #8e4ae2 0%, #a55bf5 100%);
  }

  .stat-mini-value {
    font-size: 13px;
    color: #999;
    min-width: 40px;
    text-align: right;
  }

  .empty-role {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 16px;
    padding: 40px 20px;
    text-align: center;
  }

  .empty-role p {
    color: #666;
    font-size: 14px;
  }

  .hiring-section h3 {
    font-size: 22px;
    font-weight: 600;
    color: #ffffff;
    margin: 24px 0;
  }

  .candidates-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
    gap: 20px;
  }

  .candidate-card {
    background: rgba(30, 30, 30, 0.6);
    border: 1px solid rgba(255, 255, 255, 0.1);
    border-radius: 12px;
    padding: 24px;
    transition: all 0.3s ease;
  }

  .candidate-card:hover {
    background: rgba(40, 40, 40, 0.7);
    border-color: rgba(255, 255, 255, 0.2);
    transform: translateY(-4px);
    box-shadow: 0 12px 24px rgba(0, 0, 0, 0.4);
  }

  .btn-hire:hover {
    transform: translateY(-2px) scale(1.02);
  }

  .btn-fire:hover {
    transform: translateY(-2px) scale(1.02);
  }

  .empty-state {
    grid-column: 1 / -1;
    text-align: center;
    padding: 60px 20px;
    color: #666;
    font-size: 15px;
  }
</style>