get:
	flutter pub get

analyze:
	flutter analyze

format:
	dart format lib --set-exit-if-changed

runner:
	flutter pub get

	dart run build_runner build --delete-conflicting-outputs

clean:
	flutter clean

watch:
	dart run build_runner watch

intl:
	dart run intl_utils:generate