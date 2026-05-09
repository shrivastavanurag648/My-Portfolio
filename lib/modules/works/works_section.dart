import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:polymorphism/core/constant.dart';
import 'package:polymorphism/shared/animations/scroll_reveal.dart';

enum ProjectType { mobile, desktop }

class WorksSection extends StatefulWidget {
  const WorksSection({super.key, this.scrollController});

  final ScrollController? scrollController;

  @override
  State<WorksSection> createState() => _WorksSectionState();
}

class _WorksSectionState extends State<WorksSection> {
  double _headerScrollOffset = 0;
  double _textWidth = 0;
  late final GlobalKey _worksKey;
  late final GlobalKey _textKey;

  @override
  void initState() {
    super.initState();
    _worksKey = GlobalKey();
    _textKey = GlobalKey();
    widget.scrollController?.addListener(_updateHeaderScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateTextWidth();
    });
  }

  @override
  void didUpdateWidget(WorksSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateTextWidth();
    });
  }

  @override
  void dispose() {
    widget.scrollController?.removeListener(_updateHeaderScroll);
    super.dispose();
  }

  void _calculateTextWidth() {
    final textContext = _textKey.currentContext;
    if (textContext != null) {
      final textBox = textContext.findRenderObject() as RenderBox?;
      if (textBox != null) {
        setState(() {
          _textWidth = textBox.size.width;
        });
      }
    }
  }

  void _updateHeaderScroll() {
    if (!mounted ||
        widget.scrollController == null ||
        !widget.scrollController!.hasClients) {
      return;
    }

    final worksContext = _worksKey.currentContext;
    if (worksContext == null) {
      return;
    }

    final worksBox = worksContext.findRenderObject() as RenderBox?;
    if (worksBox == null) {
      return;
    }

    final worksPosition = worksBox.localToGlobal(Offset.zero);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final scrollPosition = widget.scrollController!.offset;

    final worksTop = worksPosition.dy + scrollPosition;
    final worksBottom = worksTop + worksBox.size.height;

    final viewportTop = scrollPosition;
    final viewportBottom = scrollPosition + screenHeight;

    if (worksTop <= viewportBottom && worksBottom >= viewportTop) {
      final sectionProgress = ((scrollPosition - (worksTop - screenHeight)) /
              (worksBox.size.height + screenHeight))
          .clamp(0.0, 1.0);

      final maxScrollDistance =
          (_textWidth > screenWidth)
              ? (_textWidth - screenWidth + horizontalPadding(context) * 4) *
                  1.1
              : 0.0;

      setState(() {
        _headerScrollOffset = sectionProgress * maxScrollDistance;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return SizedBox(
      key: _worksKey,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          if (isMobile) ...[
            _buildProject(
              context,
              'Wander-lust',
              'A blazingly fast, zero-dependency tourism platform built with CSS and JavaScript. It delivers a highly responsive, animated booking experience straight from low-level POSIX sockets',
              [
                'assets/images/works/project1-1.png',
                'assets/images/works/project1-2.png',
                'assets/images/works/project1-3.png',
              ],
              ProjectType.desktop,
            ),
            _buildProject(
              context,
              'Tenant Intelligence System',
              'A privacy-first platform where tenants anonymously report housing issues while AI aggregates and analyzes complaints to expose recurring problems and repeat-offender landlords.',
              [
                'assets/images/works/project2-1.png',
                'assets/images/works/project2-2.png',
                'assets/images/works/project2-3.png',
              ],
              ProjectType.desktop,
            ),
            _buildProject(
              context,
              'Nexus-Tactical Engine',
              'Engineered a high-security, full-stack spatial management platform designed to modernize student housing allocation and eliminate legacy spreadsheet dependencies. The system features a strictly decoupled RESTful architecture, utilizing a cinematic React.js Heads-Up Display (HUD) to provide administrators with real-time, thermal-mapped visual telemetry of building occupancy via asynchronous data polling.',
              [
                'assets/images/works/nexus_1.png',
                'assets/images/works/nexus_2.png',
                'assets/images/works/nexus_3.png',
              ],
              ProjectType.desktop,
            ),
          ] else ...[
            _buildProject(
              context,
              'Wander-lust',
              'A blazingly fast, zero-dependency tourism platform built with CSS and JavaScript. It delivers a highly responsive, animated booking experience straight from low-level POSIX sockets',
              [
                'assets/images/works/project1-1.png',
                'assets/images/works/project1-2.png',
                'assets/images/works/project1-3.png',
              ],
              ProjectType.desktop,
            ),
            _buildProject(
              context,
              'Tenant Intelligence System',
              'A privacy-first platform where tenants anonymously report housing issues while AI aggregates and analyzes complaints to expose recurring problems and repeat-offender landlords.',
              [
                'assets/images/works/project2-1.png',
                'assets/images/works/project2-2.png',
                'assets/images/works/project2-3.png',
              ],
              ProjectType.desktop,
            ),
            _buildProject(
              context,
              'Nexus-Tactical Engine',
              'Engineered a high-security, full-stack spatial management platform designed to modernize student housing allocation and eliminate legacy spreadsheet dependencies. The system features a strictly decoupled RESTful architecture, utilizing a cinematic React.js Heads-Up Display (HUD) to provide administrators with real-time, thermal-mapped visual telemetry of building occupancy via asynchronous data polling.',
              [
                'assets/images/works/nexus_1.png',
                'assets/images/works/nexus_2.png',
                'assets/images/works/nexus_3.png',
              ],
              ProjectType.desktop,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      width: double.maxFinite,
      height: screenHeight(context) * (isMobile ? 0.5 : 0.7),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/paper.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: screenHeight(context) * (isMobile ? 0.35 : 0.65),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Transform.translate(
                offset: Offset(
                  -_headerScrollOffset,
                  0,
                ), // Apply horizontal scroll offset
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                    left: horizontalPadding(context) * .3,
                  ),
                  height: screenHeight(context) * (isMobile ? 0.35 : 0.65),
                  child: Text(
                    key: _textKey,
                    'DESIGNED WITH LOGIC DESIGNED WITH LOGIC DESIGNED WITH LOGIC',
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: const Color(0xFFE0E0E1),
                      fontWeight: FontWeight.w900,
                      fontSize: isMobile ? 80 : 180,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding(context),
              ),
              child:
                  isMobile
                      ? _buildMobileHeaderContent(context)
                      : _buildDesktopHeaderContent(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopHeaderContent(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
        width: screenWidth(context) * .15,
        child: Text(
          '(Works.)',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: const Color.fromARGB(255, 244, 244, 244),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Expanded(
        child: Text(
          'This piece is a confession, carved in shadow and sealed with silence',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: const Color.fromARGB(255, 244, 244, 244),
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      SizedBox(width: screenWidth(context) * .15),
    ],
  );

  Widget _buildMobileHeaderContent(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '(Works.)',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: const Color.fromARGB(255, 244, 244, 244),
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        'This piece is a confession, carved in shadow and sealed with silence.',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: const Color(0xFFE0E0E1),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );

  Widget _buildProject(
    BuildContext context,
    String title,
    String description,
    List<String> imagePaths,
    ProjectType projectType,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    if (isMobile) {
      return _buildMobileLayout(
        context,
        title,
        description,
        imagePaths,
        projectType,
      );
    } else {
      return projectType == ProjectType.mobile
          ? _buildDesktopMobileProjectLayout(
            context,
            title,
            description,
            imagePaths,
          )
          : _buildDesktopLayout(context, title, description, imagePaths);
    }
  }

  Widget _buildMobileLayout(
    BuildContext context,
    String title,
    String description,
    List<String> imagePaths,
    ProjectType projectType,
  ) => LayoutBuilder(
    builder:
        (context, constraints) => Container(
          padding: EdgeInsets.symmetric(
            vertical: verticalPadding(context),
            horizontal: horizontalPadding(context),
          ),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 253, 254, 255),
            image: DecorationImage(
              image: AssetImage('assets/images/workBg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: verticalPadding(context) * 0.5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(
                        context,
                      ).textTheme.headlineLarge!.copyWith(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: SizedBox(
                  height: screenHeight(context) * 0.4,
                  width: screenWidth(context) * 0.85,
                  child:
                      projectType == ProjectType.mobile
                          ? _ProjectImageCarouselMobile(imagePaths: imagePaths)
                          : _ProjectImageCarousel(imagePaths: imagePaths),
                ),
              ),
              SizedBox(height: verticalPadding(context) * 0.5),
            ],
          ),
        ),
  );

  Widget _buildDesktopLayout(
    BuildContext context,
    String title,
    String description,
    List<String> imagePaths,
  ) => LayoutBuilder(
    builder:
        (context, constraints) => Container(
          height: screenHeight(context),
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: verticalPadding(context),
            horizontal: horizontalPadding(context),
          ),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 253, 254, 255),
            image: DecorationImage(
              image: AssetImage('assets/images/workBg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: screenWidth(context) * .15,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: verticalPadding(context) * 2),
                      Text(
                        title,
                        style: Theme.of(
                          context,
                        ).textTheme.headlineLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.w700,
                          fontSize: 28,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: screenWidth(context) * .03),
              Expanded(child: _ProjectImageCarousel(imagePaths: imagePaths)),
            ],
          ),
        ),
  );

  Widget _buildDesktopMobileProjectLayout(
    BuildContext context,
    String title,
    String description,
    List<String> imagePaths,
  ) => LayoutBuilder(
    builder:
        (context, constraints) => Container(
          height: screenHeight(context),
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: verticalPadding(context),
            horizontal: horizontalPadding(context),
          ),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 253, 254, 255),
            image: DecorationImage(
              image: AssetImage('assets/images/workBg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: screenWidth(context) * .18,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: verticalPadding(context) * 2),
                      Text(
                        title,
                        style: Theme.of(
                          context,
                        ).textTheme.headlineLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.w700,
                          fontSize: 28,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: screenWidth(context) * .03),
              Expanded(
                child: Wrap(
                  alignment: WrapAlignment.spaceAround,
                  runSpacing: 16,
                  spacing: 16,
                  children: [
                    Tilt(
                      child: AspectRatio(
                        aspectRatio: 1440 / 960,
                        child: Image.asset(
                          imagePaths[0],
                          fit: BoxFit.cover,
                          height: screenHeight(context) * 0.7,
                          errorBuilder:
                              (context, error, stackTrace) => Container(
                                height: screenHeight(context) * 0.7,
                                width: double.infinity,
                                color: Color.fromARGB(
                                  255,
                                  253,
                                  254,
                                  255,
                                ).withValues(alpha: 0.1),
                                child: const Icon(
                                  Icons.image_not_supported,
                                  color: const Color.fromARGB(
                                    255,
                                    255,
                                    255,
                                    255,
                                  ),
                                ),
                              ),
                        ),
                      ),
                    ),
                    Tilt(
                      child: AspectRatio(
                        aspectRatio: 1440 / 960,
                        child: Image.asset(
                          imagePaths[1],
                          fit: BoxFit.cover,
                          height: screenHeight(context) * 0.7,
                          errorBuilder:
                              (context, error, stackTrace) => Container(
                                height: screenHeight(context) * 0.7,
                                width: double.infinity,
                                color: const Color.fromARGB(
                                  255,
                                  253,
                                  254,
                                  255,
                                ).withValues(alpha: 0.1),
                                child: const Icon(
                                  Icons.image_not_supported,
                                  color: const Color.fromARGB(
                                    255,
                                    255,
                                    255,
                                    255,
                                  ),
                                ),
                              ),
                        ),
                      ),
                    ),
                    Tilt(
                      child: AspectRatio(
                        aspectRatio: 1440 / 960,
                        child: Image.asset(
                          imagePaths[2],
                          fit: BoxFit.cover,
                          height: screenHeight(context) * 0.7,
                          errorBuilder:
                              (context, error, stackTrace) => Container(
                                height: screenHeight(context) * 0.7,
                                width: double.infinity,
                                color: const Color.fromARGB(
                                  255,
                                  253,
                                  254,
                                  255,
                                ).withValues(alpha: 0.1),
                                child: const Icon(
                                  Icons.image_not_supported,
                                  color: const Color.fromARGB(
                                    255,
                                    255,
                                    255,
                                    255,
                                  ),
                                ),
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
  );
}

class _ProjectImageCarousel extends StatefulWidget {
  const _ProjectImageCarousel({required this.imagePaths});

  final List<String> imagePaths;

  @override
  State<_ProjectImageCarousel> createState() => _ProjectImageCarouselState();
}

class _ProjectImageCarouselState extends State<_ProjectImageCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 768;

    return SizedBox(
      height: isMobile ? screenHeight * 0.4 : screenHeight * 0.8,
      width: isMobile ? screenWidth * 0.85 : screenWidth * 0.7,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  clipBehavior: Clip.none,
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: widget.imagePaths.length,
                  itemBuilder:
                      (context, index) => Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: isMobile ? 4 : 8,
                          vertical: isMobile ? 4 : 8,
                        ),
                        child: Tilt(
                          child: AspectRatio(
                            aspectRatio: 1440 / 960,
                            child: Image.asset(
                              widget.imagePaths[index],
                              fit: BoxFit.cover,
                              width:
                                  isMobile
                                      ? screenWidth * 0.85
                                      : screenWidth * 0.7,
                              errorBuilder:
                                  (context, error, stackTrace) => Container(
                                    width:
                                        isMobile
                                            ? screenWidth * 0.85
                                            : screenWidth * 0.7,
                                    height: double.infinity,
                                    color: Color.fromARGB(
                                      255,
                                      253,
                                      254,
                                      255,
                                    ).withValues(alpha: 0.1),
                                    child: const Icon(
                                      Icons.image_not_supported,
                                      color: const Color.fromARGB(
                                        255,
                                        255,
                                        255,
                                        255,
                                      ),
                                    ),
                                  ),
                            ),
                          ),
                        ),
                      ),
                ),

                if (_currentPage > 0)
                  Positioned(
                    left: isMobile ? 8 : 16,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Container(
                          width: isMobile ? 32 : 40,
                          height: isMobile ? 32 : 40,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(
                              255,
                              253,
                              254,
                              255,
                            ).withValues(alpha: 0.7),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.chevron_left,
                            color: Colors.white.withValues(alpha: 0.8),
                            size: isMobile ? 20 : 24,
                          ),
                        ),
                      ),
                    ),
                  ),

                if (_currentPage < widget.imagePaths.length - 1)
                  Positioned(
                    right: isMobile ? 8 : 16,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Container(
                          width: isMobile ? 32 : 40,
                          height: isMobile ? 32 : 40,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(
                              255,
                              253,
                              254,
                              255,
                            ).withValues(alpha: 0.7),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.chevron_right,
                            color: Colors.white.withValues(alpha: 0.8),
                            size: isMobile ? 20 : 24,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: isMobile ? 12 : 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.imagePaths.length,
              (index) => GestureDetector(
                onTap: () {
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: isMobile ? 3 : 4),
                  width:
                      _currentPage == index
                          ? (isMobile ? 24 : 32)
                          : (isMobile ? 6 : 8),
                  height: isMobile ? 6 : 8,
                  decoration: BoxDecoration(
                    color:
                        _currentPage == index
                            ? const Color.fromARGB(
                              255,
                              253,
                              254,
                              255,
                            ).withValues(alpha: 0.8)
                            : const Color.fromARGB(
                              255,
                              253,
                              254,
                              255,
                            ).withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectImageCarouselMobile extends StatefulWidget {
  const _ProjectImageCarouselMobile({required this.imagePaths});

  final List<String> imagePaths;

  @override
  State<_ProjectImageCarouselMobile> createState() =>
      _ProjectImageCarouselMobileState();
}

class _ProjectImageCarouselMobileState
    extends State<_ProjectImageCarouselMobile> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 768;

    return SizedBox(
      height: isMobile ? screenHeight * 0.4 : screenHeight * 0.8,
      width:
          isMobile
              ? screenHeight * 0.25
              : screenHeight * 0.45, // Portrait ratio based on height
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  clipBehavior: Clip.none,
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: widget.imagePaths.length,
                  itemBuilder:
                      (context, index) => Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: isMobile ? 4 : 8,
                          vertical: isMobile ? 4 : 8,
                        ),
                        child: Tilt(
                          child: AspectRatio(
                            aspectRatio: 1440 / 960,
                            child: Image.asset(
                              widget.imagePaths[index],
                              fit: BoxFit.cover,
                              height:
                                  isMobile
                                      ? screenHeight * 0.4
                                      : screenHeight * 0.8,
                              errorBuilder:
                                  (context, error, stackTrace) => Container(
                                    height:
                                        isMobile
                                            ? screenHeight * 0.4
                                            : screenHeight * 0.8,
                                    width: double.infinity,
                                    color: Color.fromARGB(
                                      255,
                                      253,
                                      254,
                                      255,
                                    ).withValues(alpha: 0.1),
                                    child: const Icon(
                                      Icons.image_not_supported,
                                      color: const Color.fromARGB(
                                        255,
                                        255,
                                        255,
                                        255,
                                      ),
                                    ),
                                  ),
                            ),
                          ),
                        ),
                      ),
                ),

                if (_currentPage > 0)
                  Positioned(
                    left: isMobile ? 8 : 16,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Container(
                          width: isMobile ? 32 : 40,
                          height: isMobile ? 32 : 40,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(
                              255,
                              253,
                              254,
                              255,
                            ).withValues(alpha: 0.7),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.chevron_left,
                            color: Colors.white.withValues(alpha: 0.8),
                            size: isMobile ? 20 : 24,
                          ),
                        ),
                      ),
                    ),
                  ),

                if (_currentPage < widget.imagePaths.length - 1)
                  Positioned(
                    right: isMobile ? 8 : 16,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Container(
                          width: isMobile ? 32 : 40,
                          height: isMobile ? 32 : 40,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(
                              255,
                              253,
                              254,
                              255,
                            ).withValues(alpha: 0.7),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.chevron_right,
                            color: Colors.white.withValues(alpha: 0.8),
                            size: isMobile ? 20 : 24,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: isMobile ? 12 : 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.imagePaths.length,
              (index) => GestureDetector(
                onTap: () {
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: isMobile ? 3 : 4),
                  width:
                      _currentPage == index
                          ? (isMobile ? 24 : 32)
                          : (isMobile ? 6 : 8),
                  height: isMobile ? 6 : 8,
                  decoration: BoxDecoration(
                    color:
                        _currentPage == index
                            ? const Color.fromARGB(
                              255,
                              253,
                              254,
                              255,
                            ).withValues(alpha: 0.8)
                            : const Color.fromARGB(
                              255,
                              253,
                              254,
                              255,
                            ).withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
