package com.cskbank.exceptions;

public class SessionFilterException extends Exception {
	private static final long serialVersionUID = 1L;
	private String url;
	private boolean redirect;
	private boolean showError = false;
	private boolean continueFilter = false;

	public SessionFilterException(String message, String url, boolean redirect) {
		super(message);
		this.url = url;
		this.redirect = redirect;
		this.showError = true;
	}

	public SessionFilterException(String url, boolean redirect) {
		super();
		this.url = url;
		this.redirect = redirect;
	}

	public SessionFilterException() {
		super();
		this.continueFilter = true;
	}

	public boolean isRedirect() {
		return redirect;
	}

	public String getURL() {
		return url;
	}

	public boolean isErrorAvailable() {
		return showError;
	}
}
