import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:softwareipj_app/screens/login.dart';

class CustomDrawer extends StatefulWidget {
  final Function(bool) onThemeToggle;
  final bool isDarkMode;

  const CustomDrawer({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late bool isDarkMode;

  @override
  void initState() {
    super.initState();
    // Inicializa o estado do tema conforme o valor passado do pai
    isDarkMode = widget.isDarkMode;
  }

  @override
  void didUpdateWidget(covariant CustomDrawer oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Se o valor do tema for atualizado, sincroniza o estado
    if (oldWidget.isDarkMode != widget.isDarkMode) {
      setState(() {
        isDarkMode = widget.isDarkMode;
      });
    }
  }

  void _handleThemeToggle(bool value) {
    setState(() {
      isDarkMode = value;
    });
    widget.onThemeToggle(value); // Chama o callback para alterar o tema global
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Drawer(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Column(
          children: [
            _buildMenuHeader(),
            _buildThemeToggle(),
            _buildLogoutButton(),
            const Spacer(),
            _buildAppVersionInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 50, bottom: 50),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          'Menu',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontSize: 28,
              ),
        ),
      ),
    );
  }

  Widget _buildThemeToggle() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            _handleThemeToggle(!isDarkMode);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomSwitch(
                value: isDarkMode,
                onChanged: _handleThemeToggle,
              ),
              const SizedBox(width: 20),
              Text(
                'Cor do sistema',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(
                  onThemeToggle: widget.onThemeToggle,
                  isDarkMode: isDarkMode,
                ),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/exit.svg',
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 50),
              Text(
                'Sair do app',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppVersionInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          'v.0.2.0',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}

// Widget personalizado para o Switch com ícone no círculo
class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 60,
        height: 30,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: value ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Align(
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: value ? const Color(0xFF585858) : Colors.yellow.shade700,
            ),
            child: Icon(
              value ? Icons.dark_mode : Icons.light_mode,
              color: value ? const Color(0xFF1E1E1E) : Colors.black,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }
}
