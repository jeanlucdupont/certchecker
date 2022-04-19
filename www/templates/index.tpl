{include file="header.tpl"}

		<div class="container-fluid page-body-wrapper">
			<div class="main-panel">
				<div class="content-wrapper">
					<div class="row" >
						<div class="col-lg-1 grid-margin stretch-card">
							<div class="card " style="height: 7rem;">
								<div class="card-body pb-0">
									<div class="d-flex align-items-center justify-content-between">
										<h2 class="text-info font-weight-bold">{$nbsite}</h2>
									</div>
									<div class="d-flex align-items-center justify-content-between">
										<h3 class="text-dark font-weight-bold ">Sites</h3>
									</div>
								</div>
							</div>
						</div>
						<div class="col-lg-1 grid-margin stretch-card">
							<div class="card" style="height: 7rem;">
								<div class="card-body pb-0">
									<div class="d-flex align-items-center justify-content-between">
										<h2 class="text-danger font-weight-bold">34</h2>
									</div>
									<div class="d-flex align-items-center justify-content-between">
										<h3 class="text-dark font-weight-bold ">Weak SSL</h3>
									</div>
								</div>
							</div>
						</div>
						<div class="col-lg-1 grid-margin stretch-card">
							<div class="card" style="height: 7rem;">
								<div class="card-body pb-0">
									<div class="d-flex align-items-center justify-content-between">
										<h2 class="text-danger font-weight-bold">34</h2>
									</div>
									<div class="d-flex align-items-center justify-content-between">
										<h3 class="text-dark font-weight-bold ">Weak ciphers</h3>
									</div>
								</div>
							</div>
						</div>
						
						<div class="col-lg-1 grid-margin stretch-card">
							<div class="card" style="height: 7rem;">
								<div class="card-body pb-0">
									<div class="d-flex align-items-center justify-content-between">
										<h2 class="text-danger font-weight-bold">29</h2>
									</div>
									<div class="d-flex align-items-center justify-content-between">
										<h3 class="text-dark font-weight-bold ">Sites at risk</h3>
									</div>
								</div>
							</div>
						</div>
						<div class="col-lg-2 grid-margin stretch-card">
							<div class="card" style="height: 7rem;">
								<div class="card-body pb-0">
									<div class="d-flex align-items-center justify-content-between">
										<h2 class="text-danger font-weight-bold">1</h2>
									</div>
									<div class="d-flex align-items-center justify-content-between ">
										<h3 class="text-dark font-weight-bold ">Expired certificates</h3>
									</div>
								</div>
							</div>
						</div>
						<div class="col-lg-2 grid-margin stretch-card">
							<div class="card" style="height: 7rem;">
								<div class="card-body pb-0">
									<div class="d-flex align-items-center justify-content-between">
										<h2 class="text-warning font-weight-bold">1</h2>
									</div>
									<div class="d-flex align-items-center justify-content-between">
										<h3 class="text-dark font-weight-bold ">Certificates to expire</h3>
									</div>
								</div>
							</div>
						</div>
						<div class="col-lg-2 grid-margin stretch-card">
							<div class="card" style="height: 7rem;">
								<div class="card-body pb-0">
									<div class="d-flex align-items-center justify-content-between">
										<h2 class="text-danger font-weight-bold">2</h2>
									</div>
									<div class="d-flex align-items-center justify-content-between">
										<h3 class="text-dark font-weight-bold ">Failed connections</h3>
									</div>
								</div>
							</div>
						</div>

					</div>
					<div class="row">
						<div class="col-sm grid-margin grid-margin-md-0 stretch-card">
							<div class="card" >
								<div class="card-body">
									<div class="d-flex align-items-center justify-content-between">
										<h4 class="card-title">Site list</h4>
										<h4 class="text-info font-weight-bold">{$nbsite} sites</h4>
									</div>						
									<table class="table table-condensed table-striped">
										<thead>
											<tr class="table-dark">
												<th></th>
												<th>Site</th>
												<th>SSL risks</th>
												<th>Cypher risks</th>
												<th>Expired</th>
												<th>About to expire</th>
												<th>Connection test</th>
											</tr>
										</thead>
										<tbody>
											{foreach $biglist as $item}
												<tr>
													<th><i class="fa-solid fa-folder-plus"></i></th>
													<td>{$item.address}</td>
													<td>{if $item.failcount > 0}
															<i class="text-danger fa-solid fa-network-wired"></i>
														{else}
															{if $item.sslrisk == 0}
																<i class="text-success fa-solid fa-check"></i>
															{else}
																<span class="text-danger fa-solid fa-skull"> x {$item.sslrisk}<span>
															{/if}
														{/if}
													</td>
													<td>{if $item.failcount > 0}
															<i class="text-danger fa-solid fa-network-wired"></i>
														{else}															
															{if $item.cypherrisk <= 1}
																<i class="text-success fa-solid fa-check"></i>
															{else}
																<span class="text-danger fa-solid fa-skull"> x {$item.cypherrisk}<span>
															{/if}


														{/if}
													</td>
													<td>{if $item.failcount > 0}
															<i class="text-danger fa-solid fa-network-wired"></i>
														{else}
															{if $item.daterisk > 0}
																<i class="text-success fa-solid fa-check"></i>
															{else}
																<span class="text-danger fa-solid fa-skull"> {$item.daterisk * (-1)} days ago<span>
															{/if}
														{/if}
													</td>
													<td>{if $item.failcount > 0}
															<i class="text-danger fa-solid fa-network-wired"></i>
														{else}
															{if $item.daterisk > 0 and $item.daterisk <= 30}
																<span class="text-warning fa-solid fa-skull"> in {$item.daterisk } days<span>

															{else}
																<i class="text-success fa-solid fa-check"></i>																
															{/if}
														{/if}
													</td>
													<td>{if $item.failcount > 0}
															<i class="text-danger fa-solid fa-network-wired"></i>
														{else}
															<i class="text-success fa-solid fa-network-wired"></i>
														{/if}
													</td>
												</tr>
											{/foreach}
										</tbody>
									</table>            
								</div>      
							</div>
						</div> 
					</div>
				</div>
			</div>
		</div>


{include file="footer.tpl"}