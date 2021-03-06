{include file="header.tpl"}

		<div class="container-fluid page-body-wrapper">
			<div class="main-panel">
				<form action="settings.php" method="post">
					<div class="content-wrapper">
						<div class="row">
							<div class="col-sm grid-margin grid-margin-md-0">
								<button type="submit" class="btn btn-primary" style="float: right;"><h4>Apply</h4></button>
							</div>
						</div>
						<br><div class="row">
							<div class="col-sm grid-margin grid-margin-md-0 stretch-card">
								<div class="card text-light">
									<div class="card-body bg-dark">
										<div class="d-flex align-items-center justify-content-between">
											<h4 class="card-title text-light">Approved protocols</h4>
										</div>
										<div class="row">
											{section name=idx loop=$protlist}
												<div class="col-lg-2">
													<div class="xtext">
														{$protlist[idx].ssldisplay}
													</div>
													<div class="xbutton b2" id="button-16">
														<input type='hidden' value='0' name="p{$protlist[idx].sslsuite_id}">
														<input type="checkbox" value='1' class="checkbox" {if $protlist[idx].ok == 1}checked{/if} name="p{$protlist[idx].sslsuite_id}">
														<div class="knobs"></div>
														<div class="layer"></div>
													</div>
												</div>
											{/section}
										</div>
									</div>
								</div>
							</div>
						</div>
						<br>
						<div class="row">
							<div class="col-sm grid-margin grid-margin-md-0 stretch-card">
								<div class="card text-light">
									<div class="card-body bg-dark">
										<div class="d-flex align-items-center justify-content-between">
											<h4 class="card-title text-light">Approved cypher suites</h4>
										</div>
										<div class="row">
											{foreach $cypherlist as $cypher}
												<div class="col-lg-4">
													<div class="xtext">
														{$cypher.cypher_name|replace:'_':' '}
													</div>
													<div class="xbutton b2" id="button-16">
														<input type='hidden' value='0' name="c{$cypher.cyphersuite_id}">
														<input type="checkbox" value='1' class="checkbox" {if $cypher.ok == 1}checked{/if} name="c{$cypher.cyphersuite_id}">
														<div class="knobs"></div>
														<div class="layer"></div>
													</div>
												</div>
											{/foreach}
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>
{include file="footer.tpl"}