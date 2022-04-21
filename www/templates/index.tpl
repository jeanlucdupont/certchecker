{include file="header.tpl"}

		<div class="container-fluid page-body-wrapper">
			<div class="main-panel">
				<div class="content-wrapper">
					<div class="row" >
						<div class="col-lg-2 grid-margin stretch-card">
							<div class="card bg-dark" style="height: 7rem;">
								<div class="card-body pb-0">
									<div class="d-flex align-items-center justify-content-between">
										<h1 class="text-danger font-weight-bold">{$count_ssl}</h1>
									</div>
									<div class="d-flex align-items-center justify-content-between">
										<h5 class="text-light font-weight-bold ">SSL risks</h5>
									</div>
								</div>
							</div>
						</div>
						<div class="col-lg-2 grid-margin stretch-card">
							<div class="card bg-dark" style="height: 7rem;">
								<div class="card-body pb-0">
									<div class="d-flex align-items-center justify-content-between">
										<h1 class="text-danger font-weight-bold">{$count_cypher}</h1>
									</div>
									<div class="d-flex align-items-center justify-content-between">
										<h5 class="text-light font-weight-bold ">Cipher risks</h5>
									</div>
								</div>
							</div>
						</div>				
						<div class="col-lg-2 grid-margin stretch-card">
							<div class="card bg-dark" style="height: 7rem;">
								<div class="card-body pb-0">
									<div class="d-flex align-items-center justify-content-between">
										<h1 class="text-danger font-weight-bold">29</h1>
									</div>
									<div class="d-flex align-items-center justify-content-between">
										<h5 class="text-light font-weight-bold ">Sites at risk</h5>
									</div>
								</div>
							</div>
						</div>
						<div class="col-lg-2 grid-margin stretch-card">
							<div class="card bg-dark" style="height: 7rem;">
								<div class="card-body pb-0">
									<div class="d-flex align-items-center justify-content-between">
										<h1 class="text-danger font-weight-bold">1</h1>
									</div>
									<div class="d-flex align-items-center justify-content-between ">
										<h5 class="text-light font-weight-bold ">Expired certificates</h5>
									</div>
								</div>
							</div>
						</div>
						<div class="col-lg-2 grid-margin stretch-card">
							<div class="card bg-dark" style="height: 7rem;">
								<div class="card-body pb-0">
									<div class="d-flex align-items-center justify-content-between">
										<h1 class="text-warning font-weight-bold">1</h1>
									</div>
									<div class="d-flex align-items-center justify-content-between">
										<h5 class="text-light font-weight-bold ">Certicates to expire</h5>
									</div>
								</div>
							</div>
						</div>
						<div class="col-lg-2 grid-margin stretch-card">
							<div class="card bg-dark" style="height: 7rem;">
								<div class="card-body pb-0">
									<div class="d-flex align-items-center justify-content-between">
										<h1 class="text-danger font-weight-bold">2</h1>
									</div>
									<div class="d-flex align-items-center justify-content-between">
										<h5 class="text-light font-weight-bold ">Failed connections</h5>
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
										<h1 class="card-title"><img src="img/certchecker-logo.png" style="width:155px;height:48px;"></h1>
										<h2 class="text-info font-weight-bold">{$count_site} sites</h2>
									</div>						
									<table class="table ">
										<thead>
											<tr>
												<th class="bg-info"></th>
												<th class="bg-info text-dark"><h4>Site</h4></th>
												<th class="bg-info text-dark"><h4>SSL risks</h4></th>
												<th class="bg-info text-dark"><h4>Cypher risks</h4></th>
												<th class="bg-info text-dark"><h4>Expired</h4></th>
												<th class="bg-info text-dark"><h4>About to expire</h4></th>
												<th class="bg-info text-dark"><h4>Connection test</h4></th>
											</tr>
										</thead>
										<tbody>
											{foreach $sitelist as $siteitem}
												<tr class="bg-dark">
													<td class="bg-dark">
														<a data-bs-toggle="collapse" href="#collapseExample{$siteitem.site_id}" aria-expanded="false" aria-controls="collapseExample{$siteitem.site_id}">
															<i class="fa-solid fa-caret-down text-info"></i>
														</a> 														
													</td>
													<td class="text-white"><h5>{$siteitem.address}</h5></td>
													<td>{if $siteitem.failcount > 0}
															<i class="text-danger fa-solid fa-network-wired"></i>
														{else}
															{if $siteitem.sslrisk == 0}
																<i class="text-success fa-solid fa-check"></i>
															{else}
																<span class="text-danger fa-solid fa-skull"> x {$siteitem.sslrisk}<span>
															{/if}
														{/if}
													</td>
													<td>{if $siteitem.failcount > 0}
															<i class="text-danger fa-solid fa-network-wired"></i>
														{else}															
															{if $siteitem.cypherrisk <= 1}
																<i class="text-success fa-solid fa-check"></i>
															{else}
																<span class="text-danger fa-solid fa-skull"> x {$siteitem.cypherrisk}<span>
															{/if}


														{/if}
													</td>
													<td>{if $siteitem.failcount > 0}
															<i class="text-danger fa-solid fa-network-wired"></i>
														{else}
															{if $siteitem.daterisk > 0}
																<i class="text-success fa-solid fa-check"></i>
															{else}
																<span class="text-danger fa-solid fa-skull"> {$siteitem.daterisk * (-1)} days ago<span>
															{/if}
														{/if}
													</td>
													<td>{if $siteitem.failcount > 0}
															<i class="text-danger fa-solid fa-network-wired"></i>
														{else}
															{if $siteitem.daterisk > 0 and $siteitem.daterisk <= 30}
																<span class="text-warning fa-solid fa-skull"> in {$siteitem.daterisk } days<span>
															{else}
																<i class="text-success fa-solid fa-check"></i>																
															{/if}
														{/if}
													</td>
													<td>{if $siteitem.failcount > 0}
															<i class="text-danger fa-solid fa-network-wired"></i>
														{else}
															<i class="text-success fa-solid fa-network-wired"></i>
														{/if}
													</td>
												</tr>
												<tr class="collapse bg-light" id="collapseExample{$siteitem.site_id}">
													<td class="bg-info"></td>
													<td style="width: 25%; vertical-align: top;">
														<span class="dns-entry-title dark">															
															DNS entries: 
														</span>															
														<span class="dns-entry text-secondary">															
															{$onedns = 0}
															{foreach $dnslist as $dnsitem}
																{if $dnsitem.site_id == $siteitem.site_id}
																	{if $onedns == 1}
																	 | 
																	{/if}
																	{$dnsitem.dns}
																	{$onedns = 1}
																{/if}
															{/foreach}
															{if $onedns == 0}
																None.
															{/if}
														</span>
													</td>
													<td class="text-danger dns-entry" style="vertical-align: top;">
														{foreach $ssllist as $sslitem}
															{if $sslitem.site_id == $siteitem.site_id}
																<div class="text-danger dns-entry">&nbsp;&nbsp;{$sslitem.ssldisplay|replace:' ':'&nbsp;'}</div>
																{$onessl = 1}
															{/if}
														{/foreach}
													</td>
													<td style="vertical-align: top;">
														{foreach $cypherlist as $cypheritem}
															{if $cypheritem.site_id == $siteitem.site_id}
																<div class="text-danger dns-entry">&nbsp;&nbsp;{$cypheritem.ssldisplay|replace:' ':'&nbsp;'}&nbsp;{$cypheritem.cypher_name|replace:'_':'&nbsp;'|regex_replace:"/TLS|SSL/":""|replace:"WITH":""}</div>
																{$onessl = 1}
															{/if}
														{/foreach}													
													</td>
													<td colspan="2" style="vertical-align: top;">
														{foreach $certlist as $certitem}
															{if $certitem.site_id == $siteitem.site_id}
																<div class="dns-entry">
																	{if $certitem.nbdays < 0}
																		<div class="text-danger">
																			<span class="fa-solid fa-skull"></span>
																			{$certitem.commonName} <i class="fa-solid fa-arrow-right"></i> {$certitem.expiration|regex_replace:"/ .*/":""} 
																		</div>	
																	{elseif $certitem.nbdays <= 30}
																		<div class="text-warning">
																			<span class="fa-solid fa-skull"></span>
																			{$certitem.commonName} <i class="fa-solid fa-arrow-right"></i> {$certitem.expiration|regex_replace:"/ .*/":""} 
																		</div>	
																	{else}
																			<div class="text-success">
																				<span class="fa-solid fa-check"></span>
																				{$certitem.commonName} <i class="fa-solid fa-arrow-right"></i> {$certitem.expiration|regex_replace:"/ .*/":""} 
																			</div>	

																	{/if}
																</div>
															{/if}
														{/foreach}
													</td>
													<td style="vertical-align: top;">
														{if $siteitem.failcount == 0}
															<div class="text-success dns-entry">
																Last connection: {$siteitem.tryts|regex_replace:"/ .*/":""}
															</div>
														{else}
															<div class="text-danger dns-entry">
																Last connection attempt failed on: {$siteitem.tryts|regex_replace:"/ .*/":""}
															</div>
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
	


{include file="footer.tpl"}