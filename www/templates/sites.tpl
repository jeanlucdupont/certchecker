{include file="header.tpl"}

		<div class="container-fluid page-body-wrapper">
			<div class="main-panel">
				<div class="content-wrapper">
					<div class="row" >
						<div class="col-sm grid-margin grid-margin-md-0 stretch-card">
							<div class="card" >
								<div class="card-body">
									<form action="sites.php" method="post">
										<input type="text" class="text-info bg-dark" name="newsite" placeholder="Enter site" style="width: 80%; height:55px; "> 
										<button type="submit" class="btn btn-primary" style="margin: -15px 0 0 0;"><h4>Add site</h4></button>
										<br>
										<small id="emailHelp" class="form-text text-muted">Format: FQDN[:port] </small>
									</form>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm grid-margin grid-margin-md-0 stretch-card">
							<div class="card" >
								<div class="card-body">
									<div class="d-flex align-items-center justify-content-between">
										<h2 class="card-title"><img src="img/ccicon.png"></h2>
										<h2 class="text-info font-weight-bold">{$count_site} sites</h2>
									</div>						
									<table class="table ">
										<thead>
											<tr>
												<th class="bg-info" width="50"></th>
												<th class="bg-info text-dark"><h4>Site</h4></th>
											</tr>
										</thead>
										<tbody>
											{foreach $sitelist as $siteitem}
												<tr class="bg-dark">
													<td class="bg-dark">
														<a onclick="return confirm('Are you sure?');" href="sites.php?idel={$siteitem.site_id}">
															<i class="fa-solid fa-trash-can text-info"></i>
														</a> 														
													</td>
													<td class="text-white"><h5>{$siteitem.address}</h5></td>
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